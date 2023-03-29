// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

CategoryCMS categoryFromJson(String str) => CategoryCMS.fromJson(json.decode(str));

String categoryToJson(CategoryCMS data) => json.encode(data.toJson());

class CategoryCMS {
  CategoryCMS({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory CategoryCMS.fromJson(Map<String, dynamic> json) => CategoryCMS(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.sliderImage,
  });

  String id;
  String title;
  String sliderImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    sliderImage: json["slider_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slider_image": sliderImage,
  };
}
