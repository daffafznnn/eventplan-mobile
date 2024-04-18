import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequiresLoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    _isLoggedIn().then((isLoggedIn) {
      if (!isLoggedIn) {
        // Jika pengguna belum login, redirect ke halaman login
        Get.offNamed('/auth/login');
      }
    });
  }

  Future<bool> _isLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');
    return token != null;
  }
}

class RequiresGuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    _isLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        // Jika pengguna sudah login, redirect ke halaman yang diinginkan
        Get.offNamed('/');
      }
    });
  }

  Future<bool> _isLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');
    return token != null;
  }
}
