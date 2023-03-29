// To parse this JSON data, do
//
//     final newDistributorShippingAdress = newDistributorShippingAdressFromJson(jsonString);

import 'dart:convert';

NewDistributorShippingAdress newDistributorShippingAdressFromJson(String str) => NewDistributorShippingAdress.fromJson(json.decode(str));

String newDistributorShippingAdressToJson(NewDistributorShippingAdress data) => json.encode(data.toJson());

class NewDistributorShippingAdress {
  NewDistributorShippingAdress({
    this.code,
    this.address,
    this.address2,
    this.postCode,
    this.city,
    this.countryRegionCode,
    this.phoneNo,
    this.name,
    this.contact,
    this.states,
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
  States states;

  factory NewDistributorShippingAdress.fromJson(Map<String, dynamic> json) => NewDistributorShippingAdress(
    code: json["code"],
    address: json["address"],
    address2: json["address_2"],
    postCode: json["post_code"],
    city: json["city"],
    countryRegionCode: json["country_region_code"],
    phoneNo: json["phone_no"],
    name: json["name"],
    contact: json["contact"],
    states: json["states"],
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
    "states": states.toJson(),
  };
}

class States {
  States({
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

  factory States.fromJson(Map<String, dynamic> json) => States(
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
