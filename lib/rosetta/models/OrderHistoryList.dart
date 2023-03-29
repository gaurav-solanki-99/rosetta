// To parse this JSON data, do
//
//     final orderHistoryList = orderHistoryListFromJson(jsonString);

import 'dart:convert';


OrderHistoryList orderHistoryListFromJson(String str) => OrderHistoryList.fromJson(json.decode(str));

String orderHistoryListToJson(OrderHistoryList data) => json.encode(data.toJson());

class OrderHistoryList {
  OrderHistoryList({
    this.total,
    this.page,
    this.purchaseOrders,
  });

  int total;
  int page;
  List<PurchaseOrderHitory> purchaseOrders;

  factory OrderHistoryList.fromJson(Map<String, dynamic> json) => OrderHistoryList(
    total: json["total"],
    page: json["page"],
    purchaseOrders: List<PurchaseOrderHitory>.from(json["purchaseOrders"].map((x) => PurchaseOrderHitory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "purchaseOrders": List<dynamic>.from(purchaseOrders.map((x) => x.toJson())),
  };
}

class PurchaseOrderHitory {
  PurchaseOrderHitory({
    this.id,
    this.number,
    this.amount,
    this.createdAt,
    this.status,
    this.dealerName,
    this.pos,
    this.soNumbers,
  });

  int id;
  String number;
  var amount;
  String createdAt;
  String status;
  dynamic dealerName;
  List<Po> pos;
  List<String> soNumbers;

  factory PurchaseOrderHitory.fromJson(Map<String, dynamic> json) => PurchaseOrderHitory(
    id: json["id"],
    number: json["number"],
    amount: json["amount"],
    createdAt: json["created_at"],
    status: json["status"],
    dealerName: json["dealer_name"],
    pos: List<Po>.from(json["pos"].map((x) => Po.fromJson(x))),
    soNumbers: List<String>.from(json["so_numbers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "amount": amount,
    "created_at": createdAt,
    "status": status,
    "dealer_name": dealerName,
    "pos": List<dynamic>.from(pos.map((x) => x.toJson())),
    "so_numbers": List<dynamic>.from(soNumbers.map((x) => x)),
  };
}

class Po {
  Po({
    this.id,
    this.soNumber,
  });

  int id;
  String soNumber;

  factory Po.fromJson(Map<String, dynamic> json) => Po(
    id: json["id"],
    soNumber: json["so_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "so_number": soNumber,
  };
}
