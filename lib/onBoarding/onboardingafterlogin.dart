import 'package:er_sathi/db_helper/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingAfterLogin extends StatefulWidget {
  const OnboardingAfterLogin({super.key});

  @override
  State<OnboardingAfterLogin> createState() => _OnboardingAfterLoginState();
}

class _OnboardingAfterLoginState extends State<OnboardingAfterLogin> {
  // input fields
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _universityController = TextEditingController();
  final _programController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isLoading = false;
  bool _isSubmitting = false;


  @override
  void initState(){
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() => _isLoading = true);
    try {
      final authProvider = Provider.of<ApiService>(context, listen: false);
      await authProvider.fetchUserProfile();

      if (authProvider.userProfile != null) {
        final profile = authProvider.userProfile!;
        _firstNameController.text = profile['user']['first_name'] ?? '';
        _lastNameController.text = profile['user']['last_name'] ?? '';
        _universityController.text = profile['university'] ?? '';
        _programController.text = profile['program'] ?? '';
        _phoneController.text = profile['phone_number'] ?? '';
        // _bioController.text = profile['bio'] ?? '';
        // _addressController.text = profile['address'] ?? '';

      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to load profile: ${e.toString()}"),
            backgroundColor: Colors.red,
          )
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
      Future<void> _submitForm() async{
        if(!_formKey.currentState!.validate()) return;
        setState(() => _isSubmitting=true);

        try{
          final authProvider = Provider.of<ApiService>(context, listen:false);

          final profileData = {
            'first_name': _firstNameController.text,
            'last_name': _lastNameController.text,
            'university': _universityController.text,
            'program': _programController.text,
            'phone_number': _phoneController.text,
            // 'address': _addressController.text,
          };

          final success = await authProvider.updateProfile(profileData);

          if(success){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: Colors.green,
              )
            );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to update profile"),
              backgroundColor: Colors.red,)
            );
          }
        }
         catch(e){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${e.toString()}"),
            backgroundColor: Colors.red,)
          );
         }finally {
          setState(() => _isSubmitting = false);
      }
  }


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _universityController.dispose();
    _programController.dispose();
    _phoneController.dispose();
    // _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      if(_isLoading){
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
    return Scaffold(
      // appbar
        appBar: AppBar(
          title: Text("Complete Your Profile"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {

            },),
          actions: [
            TextButton(onPressed: () {},
              child: Text(
                "Skip", style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w500),
              ),
            )
          ],

        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(18),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        // field for profile image to upload
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.deepPurple.shade200,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                            child: Image.asset(
                              "assets/images/profile.jpeg", fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.deepPurple,
                              ),)
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple.shade600,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                )
                            ),
                            child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18
                            )
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text("Personal Information", style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple.shade900,
                )),
                SizedBox(height: 8),
                Text("Complete your profile to get personalized learning experience", style: GoogleFonts.poppins(
                  color: Colors.grey.shade600,
                )),
                SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              // taking first name of user
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                labelText: "First Name",
                                prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.deepPurple.shade400),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.deepPurple.shade600,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.deepPurple.shade300)
                                )
                              ),
                              validator: (value){
                                // give warning in case of not filled
                                if(value==null || value.isEmpty){
                                  return "Please enter your first name";
                                }
                                return null;
                              }
                            )
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              // taking last name from user
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                labelText: "Last Name",
                                floatingLabelStyle: TextStyle(
                                  color: Colors.deepPurple.shade600,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.deepPurple.shade400)
                                )
                              ),
                              validator: (value){
                                // give warning in case of not filled
                                if(value==null || value.isEmpty){
                                  return "Please enter your last name";
                                }
                                return null;
                              }
                            ),
                          )
                        ]
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        // taking university name from user
                        controller: _universityController,
                        decoration: InputDecoration(
                          labelText: "University/Institution",
                          prefixIcon: Icon(Icons.school_outlined, color: Colors.deepPurple.shade400),
                          floatingLabelStyle: TextStyle(color: Colors.deepPurple.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.deepPurple.shade400)
                          )
                        ),
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return "Please enter your university name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        // taking program of study from user
                        controller: _programController,
                        decoration: InputDecoration(
                          labelText: "Program of study",
                          prefixIcon: Icon(Icons.menu_book_outlined, color: Colors.deepPurple.shade400),

                          floatingLabelStyle: TextStyle(color: Colors.deepPurple.shade600,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.deepPurple.shade400)
                          )
                        ),
                        validator: (value){
                          // give warning in case of not filed
                          if(value==null || value.isEmpty){
                            return "Enter the program of study";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        // taking phone number of user
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon: Icon(Icons.phone_android_outlined, color: Colors.deepPurple.shade400),
                          floatingLabelStyle: TextStyle(color: Colors.deepPurple.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.deepPurple.shade600),
                          )
                        ),
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return "Enter your phone number";
                          }
                          if(value.length<10){
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32),
                      // submit button to complete profile
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isSubmitting ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple.shade600,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          child: _isSubmitting? CircularProgressIndicator(color: Colors.white):
                          Text(
                            "Save Profile",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            )
                          )
                        ),
                      )
                    ]
                  )
                )
              ]
          ),
        )
    );
  }
}
