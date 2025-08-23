import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:er_sathi/utils/logger.dart';


class ApiService with ChangeNotifier{
  final String baseUrl = "http://150.230.12.113:8000/";
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
        Uri.parse("$baseUrl/auth/users/"),
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
      Uri.parse("$baseUrl/auth/users/"),
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
