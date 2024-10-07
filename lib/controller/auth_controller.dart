import 'package:flutter_application_2/Pages/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController {
  RxBool isLogin = false.obs;
  RxString userName = ''.obs;

  // Create a secure storage instance
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // API endpoints
  final String _loginUrl = 'http://10.0.2.2:3000/api/login';
  final String _registerUrl = 'http://10.0.2.2:3000/api/register';

  // Method to log in the user
  Future<void> login(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(_loginUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'username': username, 'password': password}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          String token = data['token'];
          String username = data['username'];

          await _secureStorage.write(key: 'auth_token', value: token);
          isLogin.value = true;
          userName.value = username;
          Get.snackbar("Successful", "Welcome, $username!");
          Get.offAll(() => const HomePage());
        }
      } catch (e) {
        print("Login Failed");
      }
    } else {
      Get.snackbar("Login Failed", "Please enter valid credentials.");
    }
  }

  // Method to log out the user
  Future<void> logout() async {
    isLogin.value = false; // Update the login status
    await _secureStorage.delete(
        key: 'auth_token'); // Clear token from secure storage
    Get.snackbar("Logout Successful", "You have been logged out.");
  }

  // Method to register a new user
  Future<void> register(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(_registerUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'username': username, 'password': password}),
        );

        if (response.statusCode == 201) {
          Get.snackbar("Registration Successful", "Welcome, $username!");
          Get.offAll(() => const HomePage());
        } else {
          Get.snackbar("Registration Failed", "Please try again.");
        }
      } catch (e) {
        Get.snackbar("Error", "An error occurred while registering.");
      }
    } else {
      Get.snackbar("Registration Failed", "Please enter valid credentials.");
    }
  }

  // Method to save token to secure storage
  Future<void> saveToken(String token) async {
    await _secureStorage.write(
        key: 'auth_token', value: token); // Save token to secure storage
  }

  // Method to retrieve token from secure storage
  Future<String?> getToken() async {
    return await _secureStorage.read(
        key: 'auth_token'); // Retrieve token from secure storage
  }

  Future<bool> isLoggedIn() async {
    // Check if the token exists in secure storage
    String? token = await _secureStorage.read(key: 'auth_token');

    // If the token is null, the user is not logged in
    if (token == null) {
      return false;
    }
    return true;
  }

  // Future<bool> isLoggedIn() async {
  //   // Check if the token exists in secure storage
  //   String? token = await _secureStorage.read(key: 'auth_token');

  //   // If the token is null, the user is not logged in
  //   if (token == null) {
  //     return false;
  //   }

  //   // Make a request to verify the token
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //           'http://localhost:3000/api/checktoken'), // Adjust endpoint as necessary
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization':
  //             'Bearer $token' // Send the token in the Authorization header
  //       },
  //     );

  //     // If the response is successful (200 OK), the user is logged in
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false; // Token is invalid or expired
  //     }
  //   } catch (e) {
  //     // Handle any errors (e.g., network issues)
  //     return false;
  //   }
  // }
}
