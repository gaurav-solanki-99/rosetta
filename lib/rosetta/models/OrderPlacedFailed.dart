// To parse this JSON data, do
//
//     final orderPlacedFailed = orderPlacedFailedFromJson(jsonString);

import 'dart:convert';

OrderPlacedFailed orderPlacedFailedFromJson(String str) => OrderPlacedFailed.fromJson(json.decode(str));

String orderPlacedFailedToJson(OrderPlacedFailed data) => json.encode(data.toJson());

class OrderPlacedFailed {
  OrderPlacedFailed({
    this.po,
    this.invalid,
    this.errorText,
  });

  dynamic po;
  dynamic invalid;
  String errorText;

  factory OrderPlacedFailed.fromJson(Map<String, dynamic> json) => OrderPlacedFailed(
    po: json["po"],
    invalid: json["invalid"],
    errorText: json["error_text"],
  );

  Map<String, dynamic> toJson() => {
    "po": po,
    "invalid": invalid,
    "error_text": errorText,
  };
}
