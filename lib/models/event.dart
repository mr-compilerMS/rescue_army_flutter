import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:rescue_army/utils/constants.dart';

class Event {
  final String? id;
  final String? title;
  final String? organizer;
  final String? category;
  final String? description;
  final String? imageAlt;
  final String? image;
  final String? eventVenue;
  final String? eventType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? url;
  final String? meetingUrl;
  final bool? isOffline;

  const Event({
    this.id,
    this.title,
    this.organizer,
    this.category,
    this.description,
    this.imageAlt,
    this.image,
    this.eventVenue,
    this.eventType,
    this.startDate,
    this.endDate,
    this.url,
    this.meetingUrl,
    this.isOffline,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["id"],
      title: json["title"],
      organizer: json["organizer"],
      category: json["category"],
      description: json["description"],
      imageAlt: json["image_alt"],
      image: json["image"],
      eventVenue: json["venue_land_mark"],
      eventType: json["event_type"],
      startDate: DateTime.parse(json["start_date"]),
      endDate: DateTime.parse(json["end_date"]),
      url: json["url"],
      meetingUrl: json["meeting_url"],
      isOffline: json["is_offline"],
    );
  }

  static Future<Event> fromAPI(String eid) async {
    final request = await get(
        Uri.parse(Constants.API_ENDPOINT + "/api/events/" + eid + "/"),
        headers: {
          'Authorization':
              "Token " + await FirebaseAuth.instance.currentUser!.getIdToken()
        });
    final event = Event.fromJson(jsonDecode(request.body));
    return event;
  }

  static Future<List<Event>> fetchEvents() async {
    final request =
        await get(Uri.parse(Constants.API_ENDPOINT + "/api/events/"), headers: {
      'Authorization':
          "Token " + await FirebaseAuth.instance.currentUser!.getIdToken()
    });
    print(jsonDecode(request.body));
    Iterable i = jsonDecode(
        request.body); //.map((e) => Event.fromJson(e)).toList<Event>();
    List<Event> events = List.from(i.map((e) => Event.fromJson(e)));
    return events;
  }
}
