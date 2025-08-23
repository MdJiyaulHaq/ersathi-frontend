import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:er_sathi/db_helper/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:er_sathi/loginsignupscreen/login.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose(){
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

//
//   @override
//   Widget build(BuildContext context){
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           //background
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                   Colors.deepPurple.shade800,
//                   Colors.purple.shade600,
//                 ],),
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(24),
//               child: Column(
//                 children: [
//                   SizedBox(height: 60,),
//                   AnimatedTextKit(
//                     animatedTexts: [
//                       TyperAnimatedText(
//                         "Create Account",
//                         textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                         speed: const Duration(milliseconds: 100),
//                       ),
//                     ],
//                     isRepeatingAnimation: false,
//                   ),
//                   const SizedBox(height: 8),
//                   const Text("Join us to start your Engineering Degree", style: TextStyle(fontSize: 16, color: Colors.white70),),
//                   SizedBox(height: 40,),
//
//
//                   //SignUP Form starts here
//                   Form(
//                     key: _formKey,
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             controller: _nameController,
//                               decoration: InputDecoration(
//                                 labelText: "Full Name",
//                                 prefixIcon: Icon(Icons.person),
//                               ),
//                             validator: (value){
//                               if (value==null || value.isEmpty){
//                                 return "Please enter your name";
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 20),
//                           TextFormField(
//                             controller: _emailController,
//                             decoration: const InputDecoration(
//                               labelText: "Email",
//                               prefixIcon: Icon(Icons.email),
//                             ),
//                             keyboardType: TextInputType.emailAddress,
//                             validator: (value){
//                               if(value==null || value.isEmpty){
//                                 return "Please enter your email";
//                               }
//                               if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
//                                 return "Please enter a valid email";
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 20),
//                           TextFormField(
//                             controller: _passwordController,
//                             decoration: InputDecoration(
//                               labelText: "Password",
//                               prefixIcon: Icon(Icons.lock),
//                               suffixIcon: IconButton(
//                                 icon: Icon(_obscurePassword? Icons.visibility: Icons.visibility_off),
//                                 onPressed: (){
//                                   setState(() {
//                                     _obscurePassword = !_obscurePassword;
//                                   });
//                                 },
//                               ),
//                             ),
//                             obscureText: _obscurePassword,
//                             validator: (value){
//                               if (value==null || value.isEmpty){
//                                 return "Please enter your password";
//                               }
//                               return null;
//                             },
//
//                           ),
//                           SizedBox(height: 20),
//                           TextFormField(
//                             controller: _confirmPasswordContoller,
//                             decoration: InputDecoration(
//                               labelText: "Confirm Password",
//                               prefixIcon: const Icon(Icons.lock_outline),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _obscureConfirmPassword
//                                   ? Icons.visibility : Icons.visibility_off,
//                                 ),
//                                 onPressed: (){
//                                   setState(() {
//                                     _obscureConfirmPassword = !_obscureConfirmPassword;
//                                   });
//                                 },
//                               ),
//                             ),
//                             obscureText: _obscureConfirmPassword,
//                             validator: (value){
//                               if(value==null || value.isEmpty){
//                                 return "Please confirm your password";
//                               }
//                               return null;
//                             },
//                           ),
//                           SizedBox(height: 24),
//                           if(authProvider.errorMessage.isNotEmpty)
//                             Padding(
//                                 padding: EdgeInsets.only(bottom: 16),
//                             child: Text(
//                               authProvider.errorMessage,
//                               style: const TextStyle(
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.bold
//                               ),
//                             ),),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                                 onPressed: authProvider.isLoading? null : () async{
//                                   if(_formKey.currentState!.validate()){
//                                     authProvider.clearError();
//                                     final success = await authProvider.signup(
//                                       _nameController.text.trim(),
//                                       _emailController.text.trim(),
//                                       _passwordController.text.trim(),
//                                     );
//                                     if(success){
//                                       Navigator.pushReplacementNamed(context, '/home');
//                                     }
//                                   }
//                                 }, style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.amber.shade700,
//                               foregroundColor: Colors.white,
//                               elevation: 5,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: authProvider.isLoading ? const CircularProgressIndicator(
//                               color: Colors.white,
//                             ): const Text(
//                               'Sign Up', style: TextStyle(fontSize: 18),
//                             ),),
//                           ),
//                           SizedBox(height: 20),
//                           TextButton(onPressed: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
//                           }, child: RichText(text: TextSpan(
//                             text: "Already have an account?",
//                             style: TextStyle(color: Colors.white70),
//                             children: [
//                               TextSpan(
//                                 text: 'Login',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 fontWeight: FontWeight.bold)
//                               )
//                             ]
//                           )))
//                         ],
//                       ))
//                 ],
//               ),
//             )
//           )
//         ],
//       )
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.yellow.shade300,
                    Colors.deepPurple.shade300,
                    Colors.purple.shade700,
                    Colors.yellow.shade200,
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        "Create Account",
                        textStyle: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Join us to start your Engineering Degree",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  SizedBox(height: 40),

                  // SignUP Form starts here
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscureConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != _passwordController.text) {
                              return "Passwords don't match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final response = await apiService.signup(
                                    _nameController.text.trim(),
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                    _confirmPasswordController.text.trim(),
                                  );

                                  if (response['success'] == true) {
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(response['message'] ??
                                            'Signup failed'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error: ${e.toString()}'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber.shade700,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account?",
                              style: TextStyle(color: Colors.white70),
                              children: [
                                TextSpan(
                                  text: ' Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}