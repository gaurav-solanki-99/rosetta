// To parse this JSON data, do
//
//     final dealersPosDistributor = dealersPosDistributorFromJson(jsonString);

import 'dart:convert';

DealersPosDistributor dealersPosDistributorFromJson(String str) => DealersPosDistributor.fromJson(json.decode(str));

String dealersPosDistributorToJson(DealersPosDistributor data) => json.encode(data.toJson());

class DealersPosDistributor {
  DealersPosDistributor({
    this.total,
    this.page,
    this.salesOrders,
  });

  int total;
  int page;
  List<SalesOrder> salesOrders;

  factory DealersPosDistributor.fromJson(Map<String, dynamic> json) => DealersPosDistributor(
    total: json["total"],
    page: json["page"],
    salesOrders: List<SalesOrder>.from(json["salesOrders"].map((x) => SalesOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "salesOrders": List<dynamic>.from(salesOrders.map((x) => x.toJson())),
  };
}

class SalesOrder {
  SalesOrder({
    this.id,
    this.number,
    this.amount,
    this.createdAt,
    this.status,
    this.items,
    this.customer,
    this.customerType,
    this.distributorId,
    this.dealerName,
    this.soNumbers,
  });

  int id;
  String number;
  double amount;
  String createdAt;
  String status;
  int items;
  Customer customer;
  String customerType;
  int distributorId;
  dynamic dealerName;
  List<String> soNumbers;

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
    id: json["id"],
    number: json["number"],
    amount: json["amount"].toDouble(),
    createdAt: json["created_at"],
    status: json["status"],
    items: json["items"],
    customer: Customer.fromJson(json["customer"]),
    customerType: json["customer_type"],
    distributorId: json["distributor_id"],
    dealerName: json["dealer_name"],
    soNumbers: List<String>.from(json["so_numbers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "amount": amount,
    "created_at": createdAt,
    "status": status,
    "items": items,
    "customer": customer.toJson(),
    "customer_type": customerType,
    "distributor_id": distributorId,
    "dealer_name": dealerName,
    "so_numbers": List<dynamic>.from(soNumbers.map((x) => x)),
  };
}

class Customer {
  Customer({
    this.id,
    this.navId,
    this.name,
    this.type,
    this.distributorId,
    this.stateCode,
  });

  int id;
  String navId;
  String name;
  String type;
  int distributorId;
  String stateCode;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    navId: json["nav_id"],
    name: json["name"],
    type: json["type"],
    distributorId: json["distributor_id"],
    stateCode: json["state_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nav_id": navId,
    "name": name,
    "type": type,
    "distributor_id": distributorId,
    "state_code": stateCode,
  };
}
