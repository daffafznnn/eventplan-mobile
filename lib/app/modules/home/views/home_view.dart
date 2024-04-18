import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../auth/controllers/auth_controller.dart'; // Impor AuthController

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  void goToLoginPage() {
    Get.toNamed('/auth/login');
  }

  void logout() {
    AuthController authController = Get.find<AuthController>();
    authController.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'HomeView is working well',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                goToLoginPage();
              },
              child: const Text('Go to Login Page'),
            ),
          ],
        ),
      ),
    );
  }
}
