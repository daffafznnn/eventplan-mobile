import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/api.dart';
import 'package:eventplan_mobile/app/modules/profile/controllers/profile_controller.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var isLoggedIn = false.obs;
  var identifier = ''.obs;
  var password = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Perbarui status login berdasarkan keberadaan token di localStorage
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');

    if (token != null) {
      // Jika token ditemukan, pengguna dianggap telah login
      isLoggedIn.value = true;
    } else {
      // Jika token tidak ditemukan, pengguna dianggap belum login
      isLoggedIn.value = false;
    }
  }

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
        // Panggil fetchUserProfile() dari ProfileController setelah login berhasil
        Get.find<ProfileController>().fetchUserProfile();
        Get.offAllNamed('/');
        isLoggedIn.value = true;
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
    var requestBody = {
      'identifier': identifier.value,
      'password': password.value
    };

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

    // Perbarui status login setelah logout
    isLoggedIn.value = false;

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
