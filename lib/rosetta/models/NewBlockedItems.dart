// To parse this JSON data, do
//
//     final newBlockedItems = newBlockedItemsFromJson(jsonString);

import 'dart:convert';

List<NewBlockedItems> newBlockedItemsFromJson(String str) => List<NewBlockedItems>.from(json.decode(str).map((x) => NewBlockedItems.fromJson(x)));

String newBlockedItemsToJson(List<NewBlockedItems> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewBlockedItems {
  NewBlockedItems({
    this.id,
    this.productId,
    this.batchNo,
    this.orderQuantity,
    this.rateType,
    this.unitPrice,
    this.discount,
    this.onlineDiscount,
    this.expires,
    this.stockPointId,
    this.distributorId,
    this.product,
    this.tax,
  });

  int id;
  int productId;
  String batchNo;
  double orderQuantity;
  String rateType;
  double unitPrice;
  double discount;
  var onlineDiscount;
  String expires;
  int stockPointId;
  dynamic distributorId;
  Product product;
  Tax tax;

  factory NewBlockedItems.fromJson(Map<String, dynamic> json) => NewBlockedItems(
    id: json["id"],
    productId: json["product_id"],
    batchNo: json["batch_no"],
    orderQuantity: json["order_quantity"].toDouble(),
    rateType: json["rate_type"],
    unitPrice: json["unit_price"].toDouble(),
    discount: json["discount"].toDouble(),
    onlineDiscount: json["onlineDiscount"],
    expires: json["expires"],
    stockPointId: json["stock_point_id"],
    distributorId: json["distributor_id"],
    product: Product.fromJson(json["product"]),
    tax: Tax.fromJson(json["tax"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "batch_no": batchNo,
    "order_quantity": orderQuantity,
    "rate_type": rateType,
    "unit_price": unitPrice,
    "discount": discount,
    "onlineDiscount": onlineDiscount,
    "expires": expires,
    "stock_point_id": stockPointId,
    "distributor_id": distributorId,
    "product": product.toJson(),
    "tax": tax.toJson(),
  };
}

class Product {
  Product({
    this.id,
    this.navId,
    this.name,
    this.baseUnitOfMeasure,
    this.imageUrl,
    this.category,
    this.collection,
    this.colour,
  });

  int id;
  String navId;
  String name;
  String baseUnitOfMeasure;
  String imageUrl;
  Category category;
  Col collection;
  Col colour;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    navId: json["nav_id"],
    name: json["name"],
    baseUnitOfMeasure: json["base_unit_of_measure"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    category: Category.fromJson(json["category"]),
    collection: Col.fromJson(json["collection"]),
    colour: Col.fromJson(json["colour"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nav_id": navId,
    "name": name,
    "base_unit_of_measure": baseUnitOfMeasure,
    "image_url": imageUrl == null ? null : imageUrl,
    "category": category.toJson(),
    "collection": collection.toJson(),
    "colour": colour.toJson(),
  };
}

class Category {
  Category({
    this.code,
    this.displayName,
    this.description,
    this.allowCl,
    this.clPercent,
    this.inMultiples,
    this.plankSize,
  });

  String code;
  String displayName;
  String description;
  bool allowCl;
  var clPercent;
  var inMultiples;
  var plankSize;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    code: json["code"],
    displayName: json["display_name"],
    description: json["description"],
    allowCl: json["allow_cl"],
    clPercent: json["cl_percent"],
    inMultiples: json["in_multiples"],
    plankSize: json["plank_size"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display_name": displayName,
    "description": description,
    "allow_cl": allowCl,
    "cl_percent": clPercent,
    "in_multiples": inMultiples,
    "plank_size": plankSize,
  };
}

class Col {
  Col({
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
  double inMultiples;
  String categoryCode;
  double plankSize;

  factory Col.fromJson(Map<String, dynamic> json) => Col(
    code: json["code"],
    displayName: json["display_name"],
    description: json["description"] == null ? null : json["description"],
    inMultiples: json["in_multiples"].toDouble(),
    categoryCode: json["category_code"] == null ? null : json["category_code"],
    plankSize: json["plank_size"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display_name": displayName,
    "description": description == null ? null : description,
    "in_multiples": inMultiples,
    "category_code": categoryCode == null ? null : categoryCode,
    "plank_size": plankSize,
  };
}

class Tax {
  Tax({
    this.id,
    this.regionId,
    this.categoryCode,
    this.taxTypeCode,
    this.taxPercent,
  });

  int id;
  int regionId;
  String categoryCode;
  String taxTypeCode;
  var taxPercent;

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    id: json["id"],
    regionId: json["region_id"],
    categoryCode: json["category_code"],
    taxTypeCode: json["tax_type_code"],
    taxPercent: json["tax_percent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "region_id": regionId,
    "category_code": categoryCode,
    "tax_type_code": taxTypeCode,
    "tax_percent": taxPercent,
  };
}
