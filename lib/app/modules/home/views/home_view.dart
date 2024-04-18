import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../auth/controllers/auth_controller.dart'; // Impor AuthController
import 'dart:math';


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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightBlue[100], // Warna background biru muda
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
              ),
              Obx(
                () => Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0), // Rounded border
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      min(controller.categoryList.length,
                          6), // Menampilkan 6 kategori pertama
                      (index) => CategoryItem(
                        icon: getIconFromCategoryName(
                            controller.categoryList[index].category ?? ''),
                        title: controller.categoryList[index].category ??
                            '', // Jika null, gunakan string kosong
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ), // Warna background putih
                padding: EdgeInsets.all(16.0), // Padding untuk teks
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular Events',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: List.generate(
                        10, // Ganti dengan jumlah kartu yang diinginkan
                        (index) => Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Container(
                            height:
                                100.0, // Atur ketinggian kartu sesuai kebutuhan
                            width: double.infinity,
                            // Isi kartu kosong di sini
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0), // Rounded border
        child: Container(
          color: Colors.white,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Handle onTap
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 24.0,
                      color: Colors.blue, // Icon dengan warna biru
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

IconData getIconFromCategoryName(String categoryName) {
  switch (categoryName.toLowerCase()) {
    case "business":
      return Icons.business;
    case "entertainment":
      return Icons.movie;
    case "educational":
      return Icons.school;
    case "social":
      return Icons.people;
    case "community":
      return Icons.location_city;
    case "sports":
      return Icons.sports_soccer;
    default:
      return Icons.category;
  }
}
