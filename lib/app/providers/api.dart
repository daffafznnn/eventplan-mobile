import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static final String baseUrl = 'http://localhost:5000';

  static Future<Map<String, String>> getHeaders() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');

    if (token != null) {
      return {'Authorization': 'Bearer $token'};
    } else {
      return {};
    }
  }
}
