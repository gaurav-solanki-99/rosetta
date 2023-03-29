// To parse this JSON data, do
//
//     final mainCollection = mainCollectionFromJson(jsonString);

import 'dart:convert';

List<MainCollection> mainCollectionFromJson(String str) => List<MainCollection>.from(json.decode(str).map((x) => MainCollection.fromJson(x)));

String mainCollectionToJson(List<MainCollection> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainCollection {
  MainCollection({
    this.code,
    this.displayName,
    this.description,
    this.inMultiples,
    this.categoryCode,
    this.plankSize,
  });

  String code;
  String displayName;
  String description;
  int inMultiples;
  CategoryCode categoryCode;
  int plankSize;

  factory MainCollection.fromJson(Map<String, dynamic> json) => MainCollection(
    code: json["code"],
    displayName: json["display_name"],
    description: json["description"] == null ? null : json["description"],
    inMultiples: json["in_multiples"],
    categoryCode: categoryCodeValues.map[json["category_code"]],
    plankSize: json["plank_size"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display_name": displayName,
    "description": description == null ? null : description,
    "in_multiples": inMultiples,
    "category_code": categoryCodeValues.reverse[categoryCode],
    "plank_size": plankSize,
  };
}

enum CategoryCode { ART_TRF }

final categoryCodeValues = EnumValues({
  "ART. TRF": CategoryCode.ART_TRF
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
