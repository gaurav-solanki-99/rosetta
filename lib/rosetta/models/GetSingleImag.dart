// To parse this JSON data, do
//
//     final getSingleImage = getSingleImageFromJson(jsonString);

import 'dart:convert';

GetSingleImage getSingleImageFromJson(String str) => GetSingleImage.fromJson(json.decode(str));

String getSingleImageToJson(GetSingleImage data) => json.encode(data.toJson());

class GetSingleImage {
  GetSingleImage({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<DatumIamge> data;

  factory GetSingleImage.fromJson(Map<String, dynamic> json) => GetSingleImage(
    status: json["status"],
    message: json["message"],
    data: List<DatumIamge>.from(json["data"].map((x) => DatumIamge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumIamge {
  DatumIamge({
    this.id,
    this.imagePath,
    this.productColorCode,
    this.productsId,
  });

  String id;
  String imagePath;
  String productColorCode;
  String productsId;

  factory DatumIamge.fromJson(Map<String, dynamic> json) => DatumIamge(
    id: json["id"],
    imagePath: json["image_path"],
    productColorCode: json["product_color_code"],
    productsId: json["products_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_path": imagePath,
    "product_color_code": productColorCode,
    "products_id": productsId,
  };
}
