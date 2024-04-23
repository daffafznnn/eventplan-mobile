import 'package:get/get.dart';
import 'package:eventplan_mobile/app/data/user_profile_model.dart';
import 'package:http/http.dart' as http;
import '../../../providers/api.dart';
import 'dart:convert';

class ProfileController extends GetxController {
  var getProfileData = <User>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Cek apakah token tersedia sebelum memanggil fetchUserProfile
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;

      var apiUrl = '${Api.baseUrl}/auth/me';
      var headers = await Api.getHeaders();

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        var user = User.fromJson(jsonResponse);
        getProfileData.add(user);
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      print('Error while fetching user profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProfile() async {
    await fetchUserProfile();
  }
}
