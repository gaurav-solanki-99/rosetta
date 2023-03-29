// To parse this JSON data, do
//
//     final purchaseLineProducts = purchaseLineProductsFromJson(jsonString);

import 'dart:convert';

PurchaseLineProducts purchaseLineProductsFromJson(String str) => PurchaseLineProducts.fromJson(json.decode(str));

String purchaseLineProductsToJson(PurchaseLineProducts data) => json.encode(data.toJson());

class PurchaseLineProducts {
  PurchaseLineProducts({
    this.itemId,
    this.productId,
    this.rateType,
    this.quantity,
    this.batchNo,
    this.unitPrice,
    this.discount,
    this.onlineDiscount,
    this.stockPointId,
    this.amount,
  });

  int itemId;
  int productId;
  String rateType;
  double quantity;
  String batchNo;
  double unitPrice;
  var discount;
  var onlineDiscount;
  int stockPointId;
  String amount;

  factory PurchaseLineProducts.fromJson(Map<String, dynamic> json) => PurchaseLineProducts(
    itemId: json["item_id"],
    productId: json["product_id"],
    rateType: json["rate_type"],
    quantity: json["quantity"],
    batchNo: json["batch_no"],
    unitPrice: json["unit_price"].toDouble(),
    discount: json["discount"],
    onlineDiscount: json["onlineDiscount"],
    stockPointId: json["stock_point_id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "product_id": productId,
    "rate_type": rateType,
    "quantity": quantity,
    "batch_no": batchNo,
    "unit_price": unitPrice,
    "discount": discount,
    "onlineDiscount": onlineDiscount,
    "stock_point_id": stockPointId,
    "amount": amount,
  };
}
