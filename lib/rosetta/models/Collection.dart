// To parse this JSON data, do
//
//     final collection = collectionFromJson(jsonString);

import 'dart:convert';

Collection collectionFromJson(String str) => Collection.fromJson(json.decode(str));

String collectionToJson(Collection data) => json.encode(data.toJson());

class Collection {
  Collection({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.title,
    this.products,
  });

  String title;
  List<Product> products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.productCoverImage,
  });

  String id;
  String name="";
  String productCoverImage="https://image.shutterstock.com/shutterstock/photos/1955339317/display_1500/stock-vector-no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-1955339317.jpg";

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    productCoverImage: json["product_cover_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_cover_image": productCoverImage,
  };
}
