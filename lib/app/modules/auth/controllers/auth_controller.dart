import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/api.dart';

class AuthController extends GetxController {
 final formKey = GlobalKey<FormState>();

  var identifier = ''.obs;
  var password = ''.obs;

  void onEmailChanged(String value) {
    identifier.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }

  Future<void> login() async {
    try {
      var response = await _performLogin();
      var responseBody = json.decode(response.body);

      if (response.statusCode == 200 && responseBody['accessToken'] != null) {
        _saveUserData(responseBody);
        Get.offAllNamed('/');
      } else {
        Get.snackbar('Error', 'Login failed. ${responseBody['msg']}');
      }
    } catch (e) {
      print('Error during login: $e');
      Get.snackbar('Error', 'An error occurred during login. $e');
    }
  }

  Future<http.Response> _performLogin() async {
    var apiUrl = '/auth/login';
    var requestBody = {'identifier': identifier.value, 'password': password.value};

    return await http.post(
      Uri.parse(Api.baseUrl + apiUrl),
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<void> logout() async {
    // Hapus token dari Shared Preferences
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');

    // Redirect ke halaman login setelah logout
    Get.offAllNamed('/auth/login');
  }

  void _saveUserData(Map<String, dynamic> responseBody) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', responseBody['accessToken']);

    // Memasukkan informasi role ke dalam shared preferences
    localStorage.setString('role', responseBody['role']);
  }

  void goToRegister() {
    Get.toNamed('/register');
  }
}
