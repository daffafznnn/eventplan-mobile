import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/profile_controller.dart';
import 'package:eventplan_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:eventplan_mobile/app/data/user_profile_model.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final AuthController _controllerAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: controller.isLoading.value
              ? _buildShimmerEffect()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!_controllerAuth.isLoggedIn.value)
                          _buildSignInButton(),
                        if (_controllerAuth.isLoggedIn.value)
                          _buildProfileHeader(
                            context,
                            controller.getProfileData.first,
                          ),
                        SizedBox(height: 20),
                        if (_controllerAuth.isLoggedIn.value)
                          _buildProfileStatsCard(context),
                        SizedBox(height: 25),
                        if (_controllerAuth.isLoggedIn.value)
                          _buildLogoutButton(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, User user) {
    return Row(
      children: [
        // Display profile image
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(user.profile.url),
        ),
        SizedBox(width: 20),
        // Display user icon and username
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.person),
            SizedBox(height: 5),
            Text(
              user.user.username,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              user.user.email,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileStatsCard(BuildContext context) {
    User user = controller.getProfileData.first;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProfileStat('Events', user.eventCount.toString()),
                _buildProfileStat('Followers', user.followersCount.toString()),
                _buildProfileStat('Following', user.followingCount.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSignInButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed('/auth/login');
        },
        child: Text(
          'Sign in now',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _controllerAuth.logout();
        },
        child: Text('Logout'),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 20,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 20,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            _buildProfileStatsCardWithShimmer(),
            SizedBox(height: 20),
            _buildProfileInfoRowWithShimmer(),
            _buildProfileInfoRowWithShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStatsCardWithShimmer() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProfileStatWithShimmer(),
                _buildProfileStatWithShimmer(),
                _buildProfileStatWithShimmer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStatWithShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 20,
          color: Colors.white,
        ),
        SizedBox(height: 8),
        Container(
          width: 40,
          height: 20,
          color: Colors.white,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildProfileInfoRowWithShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Container(
            width: 100,
            height: 20,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
