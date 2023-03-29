//
import 'dart:convert';

ResponsePlaceOrder responsePlaceOrderFromJson(String str) => ResponsePlaceOrder.fromJson(json.decode(str));

String responsePlaceOrderToJson(ResponsePlaceOrder data) => json.encode(data.toJson());

class ResponsePlaceOrder {
  ResponsePlaceOrder({
    this.po,
    this.invalid,
  });

  dynamic po;
  List<dynamic> invalid;

  factory ResponsePlaceOrder.fromJson(Map<String, dynamic> json) => ResponsePlaceOrder(
    po: json["po"],
    invalid: List<dynamic>.from(json["invalid"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "po": po,
    "invalid": List<dynamic>.from(invalid.map((x) => x)),
  };
}

