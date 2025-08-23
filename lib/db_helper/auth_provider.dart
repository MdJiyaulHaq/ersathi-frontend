import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:er_sathi/utils/logger.dart';


class ApiService with ChangeNotifier{
  final String baseUrl = "http://192.168.18.9:8000/api/v1";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Map<String, dynamic>? _userProfile;
  bool _isLoading = false;
  String _errorMessage = '';

  Map<String, dynamic>?  get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<Map<String, dynamic>> signup(String username, String email, String password, String confirmPassword) async{
    AppLogger.debug("Sending POST request to signup......");
    final response = await http.post(
        Uri.parse("$baseUrl/signup/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
          "confirm_password": confirmPassword,
        })
    );
    final responseData=  jsonDecode(response.body);
    if (response.statusCode == 201) {
      AppLogger.info("Signup successful");
      return responseData;
    } else {
      AppLogger.error("Signup failed: ${responseData['error']}");
      return responseData;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    final responseData = jsonDecode(response.body);
    AppLogger.debug("Login response: $responseData");
    // save token
    if (response.statusCode == 200 &&responseData.containsKey('access')) {
      await _saveToken(responseData['access']);
      final savedToken = await _getToken();
      AppLogger.debug("Token Saved + Verified in storage: $savedToken");
    }else{
      AppLogger.error("No access token in response: $responseData");
    }
    return responseData;
  }


  Future<void> _saveToken(String token) async{
    await _storage.write(key: 'auth_token', value:token);
  }

  // get token
  Future<String?> _getToken() async{
    final token = await _storage.read(key: 'auth_token');
    AppLogger.debug("Retrieved token from storage: $token");
    return token;
  }

  //update user profile
  Future<bool> updateProfile(Map<String, dynamic> profileData) async{
    try{
      AppLogger.info("Attempting to update profile....");
      final token = await _getToken();
      AppLogger.debug("Token retrieved: ${token != null ? 'exists' : 'null'}");
      AppLogger.debug("Profile data being sent: $profileData");
      final response = await http.put(Uri.parse("$baseUrl/profile/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(profileData),
      );

      AppLogger.debug("Response status: ${response.statusCode}");
      AppLogger.debug("Response body: ${response.body}");

      if(response.statusCode == 200){
        AppLogger.info("Profile updated successfully");
        await fetchUserProfile();
        return true;
      }else{
      AppLogger.error("Failed to update profile: ${response.body}");
      notifyListeners();
      return false;
      }
    }catch(e){
      _errorMessage = "Error updating profile: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }
  //
  // Future<Map<String, dynamic>> getUserProfile() async{
  //   final token = await _getToken();
  //   if(token == null){
  //     throw Exception("no authentication token found");
  //   }
  //
  //   final response = await http.get(
  //     Uri.parse("$baseUrl/profile/"),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   if(response.statusCode == 200){
  //     return jsonDecode(response.body);
  //   }
  //   else{
  //     throw Exception("Failed to load profile:, ${response.body}");
  //   }
  // }

  Future<void> fetchUserProfile() async {
    try{
      final token = await _getToken();
      final response = await http.get(
        Uri.parse("$baseUrl/profile/data/"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if(response.statusCode == 200){
        _userProfile = jsonDecode(response.body);
        notifyListeners();
      }else{
        throw Exception('Failed to load profile');
      }
    }catch(e){
      _errorMessage = "Could not fetch profile";
      notifyListeners();
    }
  }
}





//
//
// class AuthProvider extends ChangeNotifier{
//   final DatabaseHelper _dbHelper = DatabaseHelper.instance;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   String _errorMessage = '';
//   String get errorMessage => _errorMessage;
//
//   Future<bool> login(String email, String password) async{
//     _isLoading = true;
//     notifyListeners();
//
//     try{
//       final user = await _dbHelper.getUser(email);
//       if(user ==null || user['password'] != password){
//         _errorMessage = "Invalid email or password";
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//
//       _isLoading = false;
//       _errorMessage = '';
//       notifyListeners();
//       return true;
//     }
//     catch(e){
//       _errorMessage = "An error occurred during login";
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }
//
//   Future<bool> signup(String name, String email, String password) async{
//     _isLoading = true;
//     notifyListeners();
//
//     try{
//       final existingUser = await _dbHelper.getUser(email);
//       if(existingUser != null){
//         _errorMessage = "Email already exists";
//         _isLoading = false;
//         notifyListeners();
//         return false;
//       }
//       await _dbHelper.createUser(name, email, password);
//       _isLoading = false;
//       _errorMessage= '';
//       notifyListeners();
//       return true;
//     }
//     catch(e){
//       _errorMessage = "An error occurred during signup";
//       _isLoading = false;
//       notifyListeners();
//       return false;
//     }
//   }
//   void clearError(){
//     _errorMessage = '';
//     notifyListeners();
//   }
// }
//
