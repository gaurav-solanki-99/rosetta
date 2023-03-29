// To parse this JSON data, do
//
//     final allDealerOrderHistory = allDealerOrderHistoryFromJson(jsonString);

import 'dart:convert';

AllDealerOrderHistory allDealerOrderHistoryFromJson(String str) => AllDealerOrderHistory.fromJson(json.decode(str));

String allDealerOrderHistoryToJson(AllDealerOrderHistory data) => json.encode(data.toJson());

class AllDealerOrderHistory {
  AllDealerOrderHistory({
    this.total,
    this.page,
    this.salesOrders,
  });

  int total;
  int page;
  List<SalesOrderAllDealer> salesOrders;

  factory AllDealerOrderHistory.fromJson(Map<String, dynamic> json) => AllDealerOrderHistory(
    total: json["total"],
    page: json["page"],
    salesOrders: List<SalesOrderAllDealer>.from(json["salesOrders"].map((x) => SalesOrderAllDealer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "salesOrders": List<dynamic>.from(salesOrders.map((x) => x.toJson())),
  };
}

class SalesOrderAllDealer {
  SalesOrderAllDealer({
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
    this.siNumbers,
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
  List<dynamic> siNumbers;

  factory SalesOrderAllDealer.fromJson(Map<String, dynamic> json) => SalesOrderAllDealer(
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
    siNumbers: List<dynamic>.from(json["si_numbers"].map((x) => x)),
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
    "si_numbers": List<dynamic>.from(siNumbers.map((x) => x)),
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
    this.company,
  });

  int id;
  String navId;
  String name;
  String type;
  int distributorId;
  String stateCode;
  Company company;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    navId: json["nav_id"],
    name: json["name"],
    type: json["type"],
    distributorId: json["distributor_id"],
    stateCode: json["state_code"],
    company: Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nav_id": navId,
    "name": name,
    "type": type,
    "distributor_id": distributorId,
    "state_code": stateCode,
    "company": company.toJson(),
  };
}

class Company {
  Company({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
