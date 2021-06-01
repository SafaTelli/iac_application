import 'dart:convert';

class Actus {
  String title;
  String descr;
  String date;
  Actus({
    required this.title,
    required this.descr,
    required this.date,
  });

  Actus copyWith({
    String? title,
    String? descr,
    String? date,
  }) {
    return Actus(
      title: title ?? this.title,
      descr: descr ?? this.descr,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'descr': descr,
      'date': date,
    };
  }

  factory Actus.fromMap(Map<String, dynamic> map) {
    return Actus(
      title: map['title'],
      descr: map['descr'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Actus.fromJson(String source) => Actus.fromMap(json.decode(source));

  @override
  String toString() => 'Actus(title: $title, descr: $descr, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Actus &&
        other.title == title &&
        other.descr == descr &&
        other.date == date;
  }

  @override
  int get hashCode => title.hashCode ^ descr.hashCode ^ date.hashCode;
}
