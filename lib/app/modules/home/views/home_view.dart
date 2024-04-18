import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart'; // Import package shimmer

import '../controllers/home_controller.dart';
import '../../auth/controllers/auth_controller.dart';
import 'dart:math';
import 'package:eventplan_mobile/app/modules/events/controllers/events_controller.dart';
import 'package:eventplan_mobile/app/data/event_model.dart';

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
          color: Colors.lightBlue[100],
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
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      min(controller.categoryList.length, 6),
                      (index) => CategoryItem(
                        icon: getIconFromCategoryName(
                            controller.categoryList[index].category ?? ''),
                        title: controller.categoryList[index].category ?? '',
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
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular Events',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Gunakan Obx untuk memantau eventList dan isLoading
                    Obx(
                      () {
                        final eventList =
                            Get.find<EventsController>().eventList;
                        final isLoading =
                            Get.find<EventsController>().isLoading;

                        if (isLoading.value) {
                          // Jika sedang loading, tampilkan shimmer
                          return ShimmerLoadingList();
                        } else if (eventList.isEmpty) {
                          // Jika tidak ada acara ditemukan, tampilkan pesan
                          return Center(
                            child: Text('No events found'),
                          );
                        } else {
                          // Jika ada acara, tampilkan daftar acara
                          return Column(
                            children: eventList
                                .take(6)
                                .map((event) => EventCard(event: event))
                                .toList(),
                          );
                        }
                      },
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

class EventCard extends StatelessWidget {
  final Events event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  // Handle onTap
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: Image.network(
                    event.url ?? '', // Use image instead of url
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    event.price == 0 ? "Free" : "Paid",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Toggle favorite
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              event.title ?? '',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16.0,
                ),
                SizedBox(width: 4.0),
                Text(
                  event.startDate ?? '',
                  style: TextStyle(fontSize: 14.0),
                ),
                Spacer(),
                Icon(
                  Icons.location_on,
                  size: 16.0,
                ),
                SizedBox(width: 4.0),
                Text(
                  event.eventLocations?[0].address ?? '',
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
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
        borderRadius: BorderRadius.circular(10.0),
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
                      size: 34.0,
                      color: Colors.blue,
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

class ShimmerLoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        6,
        (index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200.0,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 16.0,
                    color: Colors.grey[300],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Container(
                    width: double.infinity,
                    height: 16.0,
                    color: Colors.grey[300],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: Container(
                    width: double.infinity,
                    height: 16.0,
                    color: Colors.grey[300],
                  ),
                ),
              ],
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
