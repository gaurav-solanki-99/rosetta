// To parse this JSON data, do
//
//     final newProductsSearch = newProductsSearchFromJson(jsonString);

import 'dart:convert';

NewProductsSearch newProductsSearchFromJson(String str) => NewProductsSearch.fromJson(json.decode(str));

String newProductsSearchToJson(NewProductsSearch data) => json.encode(data.toJson());

class NewProductsSearch {
  NewProductsSearch({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<ProdectObject> data;

  factory NewProductsSearch.fromJson(Map<String, dynamic> json) => NewProductsSearch(
    status: json["status"],
    message: json["message"],
    data: List<ProdectObject>.from(json["data"].map((x) => ProdectObject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProdectObject {
  ProdectObject({
    this.categoryId,
    this.categoryTitle,
    this.categoryProducts,
  });

  String categoryId;
  String categoryTitle;
  List<CategoryProduct> categoryProducts;

  factory ProdectObject.fromJson(Map<String, dynamic> json) => ProdectObject(
    categoryId: json["category_id"],
    categoryTitle: json["category_title"],
    categoryProducts: List<CategoryProduct>.from(json["category_products"].map((x) => CategoryProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_title": categoryTitle,
    "category_products": List<dynamic>.from(categoryProducts.map((x) => x.toJson())),
  };
}

class CategoryProduct {
  CategoryProduct({
    this.id,
    this.name,
    this.productColors,
  });

  String id;
  String name;
  List<ProductColor> productColors;

  factory CategoryProduct.fromJson(Map<String, dynamic> json) => CategoryProduct(
    id: json["id"],
    name: json["name"],
    productColors: List<ProductColor>.from(json["product_colors"].map((x) => ProductColor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_colors": List<dynamic>.from(productColors.map((x) => x.toJson())),
  };
}

class ProductColor {
  ProductColor({
    this.name,
  });

  String name;

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
