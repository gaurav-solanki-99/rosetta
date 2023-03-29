// To parse this JSON data, do
//
//     final addToCartItems = addToCartItemsFromJson(jsonString);

import 'dart:convert';

AddToCartItems addToCartItemsFromJson(String str) => AddToCartItems.fromJson(json.decode(str));

String addToCartItemsToJson(AddToCartItems data) => json.encode(data.toJson());

class AddToCartItems {
  AddToCartItems({
    this.cartItems,
  });

  List<CartItem> cartItems;

  factory AddToCartItems.fromJson(Map<String, dynamic> json) => AddToCartItems(
    cartItems: List<CartItem>.from(json["cart_items"].map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
  };
}

class CartItem {
  CartItem({
    this.productId,
    this.batchNo,
    this.orderQuantity,
    this.stockPointCode,
    this.stockPointSource,
    this.rateType,
    this.unitPrice,
    this.discount,
    this.onlineDiscount,
  });

  int productId;
  String batchNo;
  String orderQuantity;
  String stockPointCode;
  String stockPointSource;
  String rateType;
  double unitPrice;
  double discount;
  int onlineDiscount;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    productId: json["product_id"],
    batchNo: json["batch_no"],
    orderQuantity: json["order_quantity"],
    stockPointCode: json["stock_point_code"],
    stockPointSource: json["stock_point_source"],
    rateType: json["rate_type"],
    unitPrice: json["unit_price"].toDouble(),
    discount: json["discount"],
    onlineDiscount: json["onlineDiscount"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "batch_no": batchNo,
    "order_quantity": orderQuantity,
    "stock_point_code": stockPointCode,
    "stock_point_source": stockPointSource,
    "rate_type": rateType,
    "unit_price": unitPrice,
    "discount": discount,
    "onlineDiscount": onlineDiscount,
  };
}
