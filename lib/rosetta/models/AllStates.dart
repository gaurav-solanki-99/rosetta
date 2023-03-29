// To parse this JSON data, do
//
//     final allSates = allSatesFromJson(jsonString);

import 'dart:convert';

List<AllSates> allSatesFromJson(String str) => List<AllSates>.from(json.decode(str).map((x) => AllSates.fromJson(x)));

String allSatesToJson(List<AllSates> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllSates {
  AllSates({
    this.code,
    this.name,
    this.country,
    this.createdAt,
    this.updatedAt,
  });

  String code;
  String name;
  Country country;
  String createdAt;
  String updatedAt;

  factory AllSates.fromJson(Map<String, dynamic> json) => AllSates(
    code: json["code"],
    name: json["name"],
    country: countryValues.map[json["country"]],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "country": countryValues.reverse[country],
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

enum Country { IN }

final countryValues = EnumValues({
  "IN": Country.IN
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
