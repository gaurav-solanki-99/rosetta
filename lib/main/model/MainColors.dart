// To parse this JSON data, do
//
//     final mainColors = mainColorsFromJson(jsonString);

import 'dart:convert';

List<MainColors> mainColorsFromJson(String str) => List<MainColors>.from(json.decode(str).map((x) => MainColors.fromJson(x)));

String mainColorsToJson(List<MainColors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainColors {
  MainColors({
    this.code,
    this.displayName,
    this.description,
    this.inMultiples,
    this.plankSize,
  });

  String code;
  String displayName;
  dynamic description;
  int inMultiples;
  int plankSize;

  factory MainColors.fromJson(Map<String, dynamic> json) => MainColors(
    code: json["code"],
    displayName: json["display_name"],
    description: json["description"],
    inMultiples: json["in_multiples"],
    plankSize: json["plank_size"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display_name": displayName,
    "description": description,
    "in_multiples": inMultiples,
    "plank_size": plankSize,
  };
}
