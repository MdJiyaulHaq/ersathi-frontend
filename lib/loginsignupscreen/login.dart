// import 'package:er_sathi/onBoarding/onboardingscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:er_sathi/db_helper/auth_provider.dart';
// import 'package:er_sathi/loginsignupscreen/signup.dart';
// import 'package:er_sathi/home_screen.dart';
// import 'package:er_sathi/onBoarding/onboardingafterlogin.dart';
// import 'package:er_sathi/utils/logger.dart';
//
// class LoginPage extends StatefulWidget{
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isLoading = false;
//
//
//     @override
//   void dispose(){
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context){
//     final apiService = Provider.of<ApiService>(context, listen:false);
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Colors.yellow.shade300,
//                       Colors.deepPurple.shade300,
//                       Colors.purple.shade700,
//                       Colors.yellow.shade200,
//                     ]),
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(24),
//               child: Column(
//                 children: [
//                   SizedBox(height: 80),
//                   AnimatedTextKit(animatedTexts: [
//                     TyperAnimatedText("Welcome Back!",
//                     textStyle: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     speed: Duration(milliseconds: 100,)),
//                   ],
//                   isRepeatingAnimation: false,),
//                   SizedBox(height: 8),
//                   Text("Login to continue your journey",
//                   style: TextStyle(fontSize: 16, color: Colors.white70),),
//                   SizedBox(height: 40),
//
//                   //Login form starts here
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: _emailController,
//                           decoration: InputDecoration(
//                             labelText: "Email",
//                             prefixIcon: Icon(Icons.email),
//                             // focusColor: Colors.white,
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (value){
//                             if(value==null || value.isEmpty){
//                               return "Please enter your email";
//                             }
//                             if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
//                         return "Please enter a valid email";
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           controller: _passwordController,
//                           decoration: InputDecoration(
//                             labelText: "Password",
//                             prefixIcon: Icon(Icons.lock),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _obscurePassword? Icons.visibility : Icons.visibility_off,
//                               ),
//                               onPressed: (){
//                                 setState((){
//                                   _obscurePassword = !_obscurePassword;
//                                 });
//                               },
//                             ),
//                           ),
//                           obscureText: _obscurePassword,
//                           validator: (value){
//                             if(value==null || value.isEmpty){
//                               return "Please enter your password";
//                             }
//                             if(value.length < 6){
//                               return "Password must be at least 6 characters";
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 24),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 55,
//                           child: ElevatedButton(
//                             onPressed: _isLoading ? null: _login,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.amber.shade700,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               elevation: 8,
//                             ),
//                             child: _isLoading ? const CircularProgressIndicator(
//                               color: Colors.white,
//                             ): Text(
//                               "Log In", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
//                             ),),
//
//                         ),
//
//                         SizedBox(height: 20),
//                         TextButton(
//                             onPressed: (){
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
//                             }, child: RichText(
//                             text: TextSpan(
//                               text: "Don\'t have an account? ",
//                               style: TextStyle(color: Colors.white70),
//                               children: [
//                                 TextSpan(
//                                   text: "Sign up",
//                                   style: TextStyle(color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                                 )
//                               ]
//                             )))
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       )
//     );
//   }
//

import 'package:er_sathi/onBoarding/onboardingscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:er_sathi/db_helper/auth_provider.dart';
import 'package:er_sathi/loginsignupscreen/signup.dart';
import 'package:er_sathi/home_screen.dart';
import 'package:er_sathi/onBoarding/onboardingafterlogin.dart';
import 'package:er_sathi/utils/logger.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _login() async {
    // Validate form first
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final apiService = Provider.of<ApiService>(context, listen: false);

      AppLogger.debug("Attempting login with API...");
      final response = await apiService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      AppLogger.debug("Login API response received");

      // Check if login was successful (has access token)
      if (response.containsKey('access')) {
        AppLogger.debug("Login successful, navigating to onboarding");

        // Login successful - navigate to onboarding
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnboardingAfterLogin())
        );
      } else {
        // Show error message from API
        final errorMessage = response['error'] ?? 'Login failed. Please try again.';
        AppLogger.error("Login failed: $errorMessage");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Handle any errors
      AppLogger.error("Login error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login error: ${e.toString()}"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                  SizedBox(height: 80),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        "Welcome Back!",
                        textStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        speed: Duration(milliseconds: 100),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Login to continue your journey",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  SizedBox(height: 40),

                  // Login form starts here
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
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
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                              ),
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
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 8,
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : Text(
                              "Log In",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: Colors.white70),
                              children: [
                                TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
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