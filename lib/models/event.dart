class Event {
  final String? id;
  final String? title;
  final String? organizerName;
  final String? categoryName;
  final String? description;
  final String? imagesName;
  final String? imagesAltText;
  final String? imagesUrl;
  final String? eventVenue;
  final String? eventType;
  final String? startDate;
  final String? endDate;
  final String? url;
  final String? meetingUrl;
  final bool? isOffline;

  const Event({
    required this.id,
    required this.title,
    required this.organizerName,
    required this.categoryName,
    required this.description,
    required this.imagesName,
    required this.imagesAltText,
    required this.imagesUrl,
    required this.eventVenue,
    required this.eventType,
    required this.startDate,
    required this.endDate,
    required this.url,
    required this.meetingUrl,
    required this.isOffline,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    print(json);
    return Event(
      id: json["id"],
      title: json["title"],
      organizerName: json["organizer_name"],
      categoryName: json["category_name"],
      description: json["description"],
      imagesName: json["images_name"],
      imagesAltText: json["images_alt_text"],
      imagesUrl: json["images_url"],
      eventVenue: json["event_venue"],
      eventType: json["event_type"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      url: json["url"],
      meetingUrl: json["meeting_url"],
      isOffline: json["is_offline"],
    );
  }
}
