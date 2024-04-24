import 'package:flutter/material.dart';
import 'package:eventplan_mobile/app/data/event_model.dart';
import 'package:flutter_html/flutter_html.dart';

class EventDetailView extends StatelessWidget {
  final Events? event;

  const EventDetailView({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Jika event kosong, kembalikan ke halaman utama secara otomatis
    if (event == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
      return Container(); // Return empty container sementara navigasi berlangsung
    }

    return WillPopScope(
      onWillPop: () async {
        // Kembalikan ke halaman utama saat tombol kembali ditekan
        Navigator.popUntil(context, ModalRoute.withName('/'));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(event?.title ?? 'Event Detail'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tampilkan gambar event di atas judul
              if (event?.url != null && event!.url!.isNotEmpty)
                Image.network(
                  event!.url!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 16.0),
              Text(
                event?.title ?? 'Unknown Title',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Date: ${_getDateText(event)}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Location: ${_getLocationText(event)}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Description:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              // Tampilkan deskripsi dalam bentuk HTML
              Html(data: event?.description ?? 'No description available'),
            ],
          ),
        ),
      ),
    );
  }

  String _getDateText(Events? event) {
    if (event != null && event.startDate != null && event.endDate != null) {
      return '${event.startDate!.toString().split(' ')[0]} - ${event.endDate!.toString().split(' ')[0]}';
    } else if (event != null && event.startDate != null) {
      return '${event.startDate!.toString().split(' ')[0]}';
    } else {
      return 'Unknown Date';
    }
  }

  String _getLocationText(Events? event) {
    if (event != null && event.typeLocation != null) {
      switch (event.typeLocation!.toLowerCase()) {
        case 'location':
          return event.eventLocations != null &&
                  event.eventLocations!.isNotEmpty
              ? event.eventLocations![0].address ?? 'Unknown Address'
              : 'Unknown Address';
        case 'online':
          return 'Online';
        case 'tba':
          return 'To Be Announced';
        default:
          return 'Unknown';
      }
    } else {
      return 'Unknown Location';
    }
  }
}
