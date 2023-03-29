// To parse this JSON data, do
//
//     final spinnerSpinnerDealerList = spinnerSpinnerDealerListFromJson(jsonString);

import 'dart:convert';

List<SpinnerSpinnerDealerList> spinnerSpinnerDealerListFromJson(String str) => List<SpinnerSpinnerDealerList>.from(json.decode(str).map((x) => SpinnerSpinnerDealerList.fromJson(x)));

String spinnerSpinnerDealerListToJson(List<SpinnerSpinnerDealerList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpinnerSpinnerDealerList {
  SpinnerSpinnerDealerList({
    this.id,
    this.navId,
    this.name,
    this.type,
    this.distributorId,
    this.stateCode,
    this.email,
    this.userEmail,
    this.userPhone,
    this.phone,
  this.company,
  });

  int id;
  String navId;
  String name;
  Type type;
  int distributorId;
  StateCode stateCode;

  String email;
  String userEmail;

  String userPhone;
  String phone;
  Company company;

  factory SpinnerSpinnerDealerList.fromJson(Map<String, dynamic> json) => SpinnerSpinnerDealerList(
    id: json["id"],
    navId: json["nav_id"],
    name: json["name"],
    type: typeValues.map[json["type"]],
    distributorId: json["distributor_id"],
    stateCode: stateCodeValues.map[json["state_code"]],
    email: json["email"],
    userEmail: json["user_email"],
    userPhone: json["user_phone"] == null ? null : json["user_phone"],
    phone: json["phone"] == null ? null : json["phone"],
   company :json['company'] != null ? new Company.fromJson(json['company']) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nav_id": navId,
    "name": name,
    "type": typeValues.reverse[type],
    "distributor_id": distributorId,
    "state_code": stateCodeValues.reverse[stateCode],

    "email": email,
    "user_email": userEmail,
    "user_phone": userPhone == null ? null : userPhone,
    "phone": phone == null ? null : phone,
    "company":company,
  };
}

enum StateCode { TN }

final stateCodeValues = EnumValues({
  "TN": StateCode.TN
});

enum Type { DEALER }

final typeValues = EnumValues({
  "Dealer": Type.DEALER
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }



}


class Company {
  int id;
  String name;

  Company({this.id, this.name});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
  }
