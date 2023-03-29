// To parse this JSON data, do
//
//     final lotInventory = lotInventoryFromJson(jsonString);

import 'dart:convert';

List<LotInventory> lotInventoryFromJson(String str) => List<LotInventory>.from(json.decode(str).map((x) => LotInventory.fromJson(x)));

String lotInventoryToJson(List<LotInventory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LotInventory {
  LotInventory({
    this.lotNo,
    this.remainingQuantity,
    this.locationCode,
    this.locationSource,
    this.locationName,
  });

  String lotNo;
  double remainingQuantity;
  String locationCode;
  String locationSource;
  String locationName;

  factory LotInventory.fromJson(Map<String, dynamic> json) => LotInventory(
    lotNo: json["lot_no"],
    remainingQuantity: json["remaining_quantity"].toDouble(),
    locationCode: json["location_code"],
    locationSource: json["location_source"],
    locationName: json["location_name"],
  );

  Map<String, dynamic> toJson() => {
    "lot_no": lotNo,
    "remaining_quantity": remainingQuantity,
    "location_code": locationCode,
    "location_source": locationSource,
    "location_name": locationName,
  };
}
