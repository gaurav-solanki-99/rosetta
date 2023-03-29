// To parse this JSON data, do
//
//     final dealerAllInformations = dealerAllInformationsFromJson(jsonString);

import 'dart:convert';

DealerAllAllInformations dealerAllInformationsFromJson(String str) => DealerAllAllInformations.fromJson(json.decode(str));

String dealerAllInformationsToJson(DealerAllAllInformations data) => json.encode(data.toJson());

class DealerAllAllInformations {
  DealerAllAllInformations({
    this.total,
    this.page,
    this.users,
  });

  int total;
  int page;
  List<User> users;

  factory DealerAllAllInformations.fromJson(Map<String, dynamic> json) => DealerAllAllInformations(
    total: json["total"],
    page: json["page"],
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.active,
    this.dealer,
  });

  int id;
  String name;
  String phone;
  dynamic email;
  bool active;
  DealerAll dealer;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    active: json["active"],
    dealer: DealerAll.fromJson(json["dealer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "active": active,
    "dealer": dealer.toJson(),
  };
}

class DealerAll {
  DealerAll({
    this.id,
    this.navId,
    this.name,
    this.contact,
    this.type,
    this.distributorId,
    this.address,
    this.address2,
    this.city,
    this.zipcode,
    this.email,
    this.phone,
    this.fax,
    this.paymentTerms,
    this.company,
    this.taxInformation,
    this.DealerSatates,
    this.distributor,
  });

  int id;
  String navId;
  String name;
  dynamic contact;
  String type;
  int distributorId;
  String address;
  dynamic address2;
  String city;
  dynamic zipcode;
  String email;
  String phone;
  dynamic fax;
  PaymentTerms paymentTerms;
  DealerAllCompany company;
  TaxInformation taxInformation;
  DealerSatate DealerSatates;
  Distributor distributor;

  factory DealerAll.fromJson(Map<String, dynamic> json) => DealerAll(
    id: json["id"],
    navId: json["nav_id"],
    name: json["name"],
    contact: json["contact"],
    type: json["type"],
    distributorId: json["distributor_id"],
    address: json["address"],
    address2: json["address2"],
    city: json["city"],
    zipcode: json["zipcode"],
    email: json["email"],
    phone: json["phone"],
    fax: json["fax"],
    paymentTerms: PaymentTerms.fromJson(json["paymentTerms"]),
    company: DealerAllCompany.fromJson(json["company"]),
    taxInformation: TaxInformation.fromJson(json["tax_information"]),
    DealerSatates: DealerSatate.fromJson(json["state"]),
    distributor: Distributor.fromJson(json["distributor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nav_id": navId,
    "name": name,
    "contact": contact,
    "type": type,
    "distributor_id": distributorId,
    "address": address,
    "address2": address2,
    "city": city,
    "zipcode": zipcode,
    "email": email,
    "phone": phone,
    "fax": fax,
    "paymentTerms": paymentTerms.toJson(),
    "company": company.toJson(),
    "tax_information": taxInformation.toJson(),
    "DealerSatates": DealerSatates.toJson(),
    "distributor": distributor.toJson(),
  };
}

class DealerAllCompany {
  DealerAllCompany({
    this.id,
    this.name,
    this.region,
  });

  int id;
  String name;
  Region region;

  factory DealerAllCompany.fromJson(Map<String, dynamic> json) => DealerAllCompany(
    id: json["id"],
    name: json["name"],
    region: Region.fromJson(json["region"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "region": region.toJson(),
  };
}

class Region {
  Region({
    this.id,
    this.name,
    this.currencyMajor,
    this.currencyMinor,
    this.countryCode,
  });

  int id;
  String name;
  String currencyMajor;
  String currencyMinor;
  String countryCode;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    id: json["id"],
    name: json["name"],
    currencyMajor: json["currency_major"],
    currencyMinor: json["currency_minor"],
    countryCode: json["country_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "currency_major": currencyMajor,
    "currency_minor": currencyMinor,
    "country_code": countryCode,
  };
}

class Distributor {
  Distributor({
    this.id,
    this.navId,
    this.name,
    this.type,
    this.address,
    this.address2,
    this.city,
    this.zipcode,
    this.email,
    this.phone,
    this.fax,
    this.company,
    this.taxInformation,
    this.DealerSatates,
  });

  int id;
  String navId;
  String name;
  String type;
  String address;
  String address2;
  String city;
  String zipcode;
  String email;
  String phone;
  dynamic fax;
  DistributorCompany company;
  TaxInformation taxInformation;
  DealerSatate DealerSatates;

  factory Distributor.fromJson(Map<String, dynamic> json) => Distributor(
    id: json["id"],
    navId: json["nav_id"],
    name: json["name"],
    type: json["type"],
    address: json["address"],
    address2: json["address2"],
    city: json["city"],
    zipcode: json["zipcode"],
    email: json["email"],
    phone: json["phone"],
    fax: json["fax"],
    company: DistributorCompany.fromJson(json["company"]),
    taxInformation: TaxInformation.fromJson(json["tax_information"]),
    DealerSatates: DealerSatate.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nav_id": navId,
    "name": name,
    "type": type,
    "address": address,
    "address2": address2,
    "city": city,
    "zipcode": zipcode,
    "email": email,
    "phone": phone,
    "fax": fax,
    "company": company.toJson(),
    "tax_information": taxInformation.toJson(),
    "DealerSatates": DealerSatates.toJson(),
  };
}

class DistributorCompany {
  DistributorCompany({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory DistributorCompany.fromJson(Map<String, dynamic> json) => DistributorCompany(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class DealerSatate {
  DealerSatate({
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

  factory DealerSatate.fromJson(Map<String, dynamic> json) => DealerSatate(
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

class TaxInformation {
  TaxInformation({
    this.gst,
    this.pan,
    this.tax,
  });

  Gst gst;
  Pan pan;
  Tax tax;

  factory TaxInformation.fromJson(Map<String, dynamic> json) => TaxInformation(
    gst: Gst.fromJson(json["gst"]),
    pan: Pan.fromJson(json["pan"]),
    tax: Tax.fromJson(json["tax"]),
  );

  Map<String, dynamic> toJson() => {
    "gst": gst.toJson(),
    "pan": pan.toJson(),
    "tax": tax.toJson(),
  };
}

class Gst {
  Gst({
    this.number,
    this.registrationType,
    this.customerType,
  });

  String number;
  PaymentTerms registrationType;
  PaymentTerms customerType;

  factory Gst.fromJson(Map<String, dynamic> json) => Gst(
    number: json["number"],
    registrationType: PaymentTerms.fromJson(json["registration_type"]),
    customerType: PaymentTerms.fromJson(json["customer_type"]),
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "registration_type": registrationType.toJson(),
    "customer_type": customerType.toJson(),
  };
}

class PaymentTerms {
  PaymentTerms({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory PaymentTerms.fromJson(Map<String, dynamic> json) => PaymentTerms(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class Pan {
  Pan({
    this.referenceNumber,
    this.number,
    this.status,
  });

  dynamic referenceNumber;
  dynamic number;
  dynamic status;

  factory Pan.fromJson(Map<String, dynamic> json) => Pan(
    referenceNumber: json["reference_number"],
    number: json["number"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "reference_number": referenceNumber,
    "number": number,
    "status": status,
  };
}

class Tax {
  Tax({
    this.lst,
    this.cst,
  });

  String lst;
  String cst;

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    lst: json["lst"] == null ? null : json["lst"],
    cst: json["cst"] == null ? null : json["cst"],
  );

  Map<String, dynamic> toJson() => {
    "lst": lst == null ? null : lst,
    "cst": cst == null ? null : cst,
  };
}
