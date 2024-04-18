import 'package:eventplan_mobile/app/modules/events/views/events_view.dart';
import 'package:eventplan_mobile/app/modules/home/views/home_view.dart';
import 'package:eventplan_mobile/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/menu_navigation_controller.dart';

class MenuNavigationView extends StatelessWidget {
  final MenuNavigationController controller =
      Get.put(MenuNavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Icon logo
            Image.asset(
              'assets/eventplan-logo.png', // Ganti dengan path logo yang sesuai
              width: 30, // Sesuaikan ukuran logo sesuai kebutuhan
              height: 30,
            ),
            SizedBox(width: 8), // Spasi antara logo dan form pencarian
            // Form input pencarian
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Rounded border
                  color:
                      Colors.grey[100], // Warna abu untuk latar belakang input
                  border: Border.all(
                    color: Colors.grey[400]!, // Warna border atau stroke
                    width: 1.0, // Lebar border atau stroke
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10), // Spasi antara border dan ikon
                    Icon(Icons.search,
                        color: Colors.grey), // Ikon searching di dalam input
                    SizedBox(width: 10), // Spasi antara ikon dan input teks
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search', // Teks hint untuk input pencarian
                          border: InputBorder.none, // Hapus border default
                          isDense:
                              true, // Ketinggian input sesuai dengan kontennya
                          contentPadding:
                              EdgeInsets.all(10), // Padding konten input
                        ),
                        onChanged: (value) {
                          // Logika untuk pencarian data
                        },
                        style: TextStyle(color: Colors.black), // Warna teks
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Ikonya bisa diletakkan di sini jika Anda ingin menambahkan ikon di kanan AppBar
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomeView(),
            EventsView(), // Tambahkan EventsView di sini
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.changePage(index),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.event),
                label: "Events"), // Tambahkan item untuk halaman Events
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: "Profile")
          ],
        ),
      ),
    );
  }
}
