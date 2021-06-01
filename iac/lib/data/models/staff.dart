import 'dart:convert';

class Staff {
  String name;
  String post;
  String image;
  Staff({
    required this.name,
    required this.post,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'post': post,
      'image': image,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      name: map['name'],
      post: map['post'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source));
}
