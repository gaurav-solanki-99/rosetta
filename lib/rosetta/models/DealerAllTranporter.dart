// To parse this JSON data, do
//
//     final dealerAllTranporter = dealerAllTranporterFromJson(jsonString);

import 'dart:convert';

DealerAllTranporter dealerAllTranporterFromJson(String str) => DealerAllTranporter.fromJson(json.decode(str));

String dealerAllTranporterToJson(DealerAllTranporter data) => json.encode(data.toJson());

class DealerAllTranporter {
  DealerAllTranporter({
    this.code,
    this.address,
    this.address2,
    this.postCode,
    this.city,
    this.countryRegionCode,
    this.phoneNo,
    this.name,
    this.contact,
    this.state,
  });

  String code;
  String address;
  String address2;
  String postCode;
  String city;
  String countryRegionCode;
  String phoneNo;
  String name;
  String contact;
  TransportSatate state;

  factory DealerAllTranporter.fromJson(Map<String, dynamic> json) => DealerAllTranporter(
    code: json["code"],
    address: json["address"],
    address2: json["address_2"],
    postCode: json["post_code"],
    city: json["city"],
    countryRegionCode: json["country_region_code"],
    phoneNo: json["phone_no"],
    name: json["name"],
    contact: json["contact"],
    state: TransportSatate.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "address": address,
    "address_2": address2,
    "post_code": postCode,
    "city": city,
    "country_region_code": countryRegionCode,
    "phone_no": phoneNo,
    "name": name,
    "contact": contact,
    "state": state.toJson(),
  };
}

class TransportSatate {
  TransportSatate({
    this.code,
    this.name,
    this.country,
    this.createdAt,
    this.updatedAt,
  });

  String code;
  String name;
  String country;
  String createdAt;
  String updatedAt;

  factory TransportSatate.fromJson(Map<String, dynamic> json) => TransportSatate(
    code: json["code"],
    name: json["name"],
    country: json["country"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "country": country,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
