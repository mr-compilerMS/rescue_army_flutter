import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:rescue_army/utils/constants.dart';

class EventImage {
  final String? image;
  final String? alternativeText;
  final String? imageThumbnail;

  EventImage({
    this.image,
    this.alternativeText,
    this.imageThumbnail,
  });

  static EventImage fromJson(Map<String, dynamic> e) {
    return EventImage(
      image: e['image'],
      alternativeText: e['alternativeText'],
      imageThumbnail: e['imageThumbnail'],
    );
  }
}

class EventVenue {
  final String? landMark;
  final String? street;
  final String? village;
  final String? city;
  final String? state;
  final String? pincode;

  EventVenue({
    this.landMark,
    this.street,
    this.village,
    this.city,
    this.state,
    this.pincode,
  });

  static EventVenue fromJson(e) {
    return EventVenue(
      landMark: e['landMark'],
      street: e['street'],
      village: e['village'],
      city: e['city'],
      state: e['state'],
      pincode: e['pincode'],
    );
  }
}

class Event {
  final String? id;
  final String? title;
  final String? organizer;
  final String? description;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? url;
  final bool? isOffline;
  final String? type;
  final List<EventImage> images;
  final List<EventVenue> venues;

  const Event({
    this.id,
    this.title,
    this.organizer,
    this.description,
    this.type,
    this.startTime,
    this.endTime,
    this.url,
    this.isOffline,
    required this.images,
    required this.venues,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["id"],
      title: json["title"],
      organizer: json["organizer"],
      description: json["description"],
      startTime: DateTime.parse(json["start_time"]),
      endTime:
          json["end_time"] != null ? DateTime.parse(json["end_time"]) : null,
      url: json["url"],
      isOffline: json["is_offline"],
      type: json["type"],
      images: (json["images"] as List<dynamic>)
          .map((e) => EventImage.fromJson(e))
          .toList(),
      venues: (json["images"] as List<dynamic>)
          .map((e) => EventVenue.fromJson(e))
          .toList(),
    );
  }

  static Future<Event> fromAPI(String eid) async {
    final request = await get(
        Uri.parse(Constants.API_ENDPOINT + "events/" + eid + "/"),
        headers: {
          'Authorization':
              "Token " + await FirebaseAuth.instance.currentUser!.getIdToken()
        });
    final event = Event.fromJson(jsonDecode(request.body));
    return event;
  }

  static Future<List<Event>> fetchEvents() async {
    final request = await get(Uri.parse(Constants.API_ENDPOINT + "/events/"));

    Map<String, dynamic> response = jsonDecode(request.body);
    final events = response['results'];
    List<Event> event = List.from(events.map((e) => Event.fromJson(e)));
    return event;
  }
}
