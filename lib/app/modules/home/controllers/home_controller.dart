import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:eventplan_mobile/app/data/categories_model.dart';
import 'package:geolocator/geolocator.dart';
import '../../../providers/api.dart';

class HomeController extends GetxController {
  var categoryList = <Category>[].obs;
   var userLocation = Rx<Position?>(null);

  @override
  void onInit() {
    fetchCategories();
     fetchUserLocation();
    super.onInit();
  }

   Future<void> fetchUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        // Handle denied forever case
        return;
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        userLocation.value = position;
      }
    } catch (e) {
      print('Error fetching user location: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      var apiUrl = '${Api.baseUrl}/event-categories';
      var headers = await Api.getHeaders();

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        categoryList.assignAll(
          jsonResponse
              .map(
                (model) => Category.fromJson(model as Map<String, dynamic>),
              )
              .toList(),
        );
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      print('Error while fetching categories: $e');
    }
  }
}
