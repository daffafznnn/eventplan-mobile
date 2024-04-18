import 'dart:convert';
import 'package:get/get.dart';
import 'package:eventplan_mobile/app/data/event_model.dart';
import 'package:http/http.dart' as http;
import '../../../providers/api.dart';

class EventsController extends GetxController {
  var eventList = <Events>[].obs;

  @override
  void onInit() {
    fetchEvents();
    super.onInit();
  }

  Future<void> fetchEvents() async {
    try {
      var apiUrl = '${Api.baseUrl}/events';
      var headers = await Api.getHeaders();

      var response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        eventList.assignAll(
          jsonResponse
              .map(
                (model) => Events.fromJson(model as Map<String, dynamic>),
              )
              .toList(),
        );
      } else {
        throw Exception('Failed to fetch events');
      }
    } catch (e) {
      print('Error while fetching events: $e');
    }
  }
}
