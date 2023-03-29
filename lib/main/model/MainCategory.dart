// To parse this JSON data, do
//
//     final mainCategory = mainCategoryFromJson(jsonString);

import 'dart:convert';

List<MainCategory> mainCategoryFromJson(String str) => List<MainCategory>.from(json.decode(str).map((x) => MainCategory.fromJson(x)));

String mainCategoryToJson(List<MainCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainCategory {
  MainCategory({
    this.code,
    this.displayName,
    this.description,
    // this.allowCl,
    // this.clPercent,
    this.inMultiples,
    this.plankSize,
  });

  String code;
  String displayName;
  String description;
  // bool allowCl;
  // int clPercent;
  double inMultiples;
  double plankSize;

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
    code: json["code"],
    displayName: json["display_name"],
    description: json["description"],
    // allowCl: json["allow_cl"],
    // clPercent: json["cl_percent"],
    inMultiples: json["in_multiples"].toDouble(),
    plankSize: json["plank_size"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display_name": displayName,
    "description": description,
    // "allow_cl": allowCl,
    // "cl_percent": clPercent,
    "in_multiples": inMultiples,
    "plank_size": plankSize,
  };
}
