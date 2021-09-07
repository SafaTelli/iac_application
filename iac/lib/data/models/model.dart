import 'dart:convert';

class Model {
  String name = "";
  String cin = "";
  Model({
    required this.name,
    required this.cin,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cin': cin,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      name: map['name'],
      cin: map['cin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));
}
