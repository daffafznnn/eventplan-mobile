import 'dart:convert';
import 'package:get/get.dart';
import 'package:eventplan_mobile/app/data/event_model.dart';
import 'package:http/http.dart' as http;
import '../../../providers/api.dart';
import 'package:eventplan_mobile/app/routes/app_pages.dart';

class EventsController extends GetxController {
  var eventList = <Events>[].obs;
  var isLoading = false.obs;

  get currentPosition => null;

  @override
  void onInit() {
    fetchEvents(); // Panggil fetchEvents di onInit
    super.onInit();
  }

  Future<void> fetchEvents() async {
    try {
      var apiUrl = '${Api.baseUrl}/events';

      var response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.isEmpty) {
          // Jika data event kosong
          print('No events found');
        } else {
          List<Events> events = jsonResponse
              .map((model) => Events.fromJson(model as Map<String, dynamic>))
              .toList();
          eventList.assignAll(events);
        }
      } else {
        throw Exception('Failed to fetch events');
      }
    } catch (e) {
      print('Error while fetching events: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void showDetailEvent(Events event) {
    Get.toNamed(Routes.EVENTS_DETAIL,
        arguments: event);
  }
}
