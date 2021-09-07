import 'dart:convert';

class Staff {
  String name;
  String post;
  String image;
  String tel;
  String email;
  Staff(
      {required this.name,
      required this.post,
      required this.image,
      required this.tel,
      required this.email});

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
        tel: map['tel'],
        email: map['email']);
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source));
}
