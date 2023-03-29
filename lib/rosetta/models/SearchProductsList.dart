// To parse this JSON data, do
//
//     final searchProductsList = searchProductsListFromJson(jsonString);

import 'dart:convert';

SearchProductsList searchProductsListFromJson(String str) => SearchProductsList.fromJson(json.decode(str));

String searchProductsListToJson(SearchProductsList data) => json.encode(data.toJson());

class SearchProductsList {
  SearchProductsList({
    this.total,
    this.page,
    this.inventory,
  });

  int total;
  int page;
  List<Inventory> inventory;

  factory SearchProductsList.fromJson(Map<String, dynamic> json) => SearchProductsList(
    total: json["total"],
    page: json["page"],
    inventory: List<Inventory>.from(json["inventory"].map((x) => Inventory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "inventory": List<dynamic>.from(inventory.map((x) => x.toJson())),
  };
}

class Inventory {
  Inventory({
    this.id,
    this.navId,
    this.name,
    this.description2,
    this.baseUnitOfMeasure,
    this.inventory,
    this.blocked,
    this.qtyOnPurchOrder,
    this.imageUrl,
    this.category,
    this.collection,
    this.colour,
    this.stockPoints,
    this.price,
  });

  int id;
  String navId;
  String name;
  String description2;
  String baseUnitOfMeasure;
  double inventory;
  double blocked;
  double qtyOnPurchOrder;
  String imageUrl;
  Category category;
  Col collection;
  Col colour;
  List<StockPoint> stockPoints;
  Price price;

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
    id: json["id"],
    navId: json["nav_id"],
    name: json["name"],
    description2: json["description_2"] == null ? null : json["description_2"],
    baseUnitOfMeasure: json["base_unit_of_measure"],
    inventory: json["inventory"].toDouble(),
    blocked: json["blocked"].toDouble(),
    qtyOnPurchOrder: json["qty_on_purch_order"].toDouble(),
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    category: Category.fromJson(json["category"]),
    collection: Col.fromJson(json["collection"]),
    colour: json["colour"] == null ? null : Col.fromJson(json["colour"]),
    stockPoints: List<StockPoint>.from(json["stock_points"].map((x) => StockPoint.fromJson(x))),
    price: Price.fromJson(json["price"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nav_id": navId,
    "name": name,
    "description_2": description2 == null ? null : description2,
    "base_unit_of_measure": baseUnitOfMeasureValues.reverse[baseUnitOfMeasure],
    "inventory": inventory,
    "blocked": blocked,
    "qty_on_purch_order": qtyOnPurchOrder,
    "category": category.toJson(),
    "collection": collection.toJson(),
    "colour": colour == null ? null : colour.toJson(),
    "stock_points": List<dynamic>.from(stockPoints.map((x) => x.toJson())),
    "price": price.toJson(),
  };
}

enum BaseUnitOfMeasure { SFT }

final baseUnitOfMeasureValues = EnumValues({
  "SFT": BaseUnitOfMeasure.SFT
});

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

  Code code;
  String displayName;
  Code description;
  bool allowCl;
  var clPercent;
  var inMultiples;
  var plankSize;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    code: codeValues.map[json["code"]],
    displayName:  json["display_name"],
    description: codeValues.map[json["description"]],
    allowCl: json["allow_cl"],
    clPercent: json["cl_percent"],
    inMultiples: json["in_multiples"],
    plankSize: json["plank_size"],
  );

  Map<String, dynamic> toJson() => {
    "code": codeValues.reverse[code],
    "display_name": codeValues.reverse[displayName],
    "description": codeValues.reverse[description],
    "allow_cl": allowCl,
    "cl_percent": clPercent,
    "in_multiples": inMultiples,
    "plank_size": plankSize,
  };
}

enum Code { CARPET }

final codeValues = EnumValues({
  "CARPET": Code.CARPET
});

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
  var inMultiples;
  Code categoryCode;
  var plankSize;

  factory Col.fromJson(Map<String, dynamic> json) => Col(
    code: json["code"],
    displayName: json["display_name"],
    description: json["description"] == null ? null : json["description"],
    inMultiples: json["in_multiples"],
    categoryCode: json["category_code"] == null ? null : codeValues.map[json["category_code"]],
    plankSize: json["plank_size"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display_name": displayName==null?null:displayName,
    "description": description == null ? null : description,
    "in_multiples": inMultiples,
    "category_code": categoryCode == null ? null : codeValues.reverse[categoryCode],
    "plank_size": plankSize,
  };
}

class Price {
  Price({
    this.unit,
    this.discount,
    this.onlineDiscount,
    this.allowCl,
    this.clPercent,
    this.taxPercent,
    this.taxTypeCode,
  });

  double unit;
  var discount;
  int onlineDiscount;
  bool allowCl;
  var clPercent;
  var taxPercent;
  TaxTypeCode taxTypeCode;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    unit: json["unit"].toDouble(),
    discount: json["discount"],
    onlineDiscount: json["onlineDiscount"],
    allowCl: json["allow_cl"],
    clPercent: json["cl_percent"],
    taxPercent: json["tax_percent"],
    taxTypeCode: taxTypeCodeValues.map[json["tax_type_code"]],
  );

  Map<String, dynamic> toJson() => {
    "unit": unit,
    "discount": discount,
    "onlineDiscount": onlineDiscount,
    "allow_cl": allowCl,
    "cl_percent": clPercent,
    "tax_percent": taxPercent,
    "tax_type_code": taxTypeCodeValues.reverse[taxTypeCode],
  };
}

enum TaxTypeCode { GST }

final taxTypeCodeValues = EnumValues({
  "GST": TaxTypeCode.GST
});

class StockPoint {
  StockPoint({
    this.id,
    this.source,
    this.name,
    this.inventory,
    this.blocked,
  });

  int id;
  String source;
  String  name;
  double inventory;
  double blocked;

  factory StockPoint.fromJson(Map<String, dynamic> json) => StockPoint(
    id: json["id"],
    source: json["source"],
    name: json["name"],
    inventory: json["inventory"].toDouble(),
    blocked: json["blocked"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "source": sourceValues.reverse[source],
    "name": name,
    "inventory": inventory,
    "blocked": blocked,
  };
}

enum Name { PUNE_DEPOT_001 }

final nameValues = EnumValues({
  "PUNE DEPOT 001": Name.PUNE_DEPOT_001
});

enum Source { STOCK_POINT }

final sourceValues = EnumValues({
  "StockPoint": Source.STOCK_POINT
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
