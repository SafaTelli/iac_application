import 'dart:convert';

class Event {
  String title;
  String date;
  String place;
  Event({
    required this.title,
    required this.date,
    required this.place,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'place': place,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'],
      date: map['date'],
      place: map['place'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}
