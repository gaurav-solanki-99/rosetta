// To parse this JSON data, do
//
//     final dealersDetsils = dealersDetsilsFromJson(jsonString);

import 'dart:convert';

DealersDetsils dealersDetsilsFromJson(String str) => DealersDetsils.fromJson(json.decode(str));

String dealersDetsilsToJson(DealersDetsils data) => json.encode(data.toJson());

class DealersDetsils {
  DealersDetsils({
    this.id,
    this.navId,
    this.name,
    this.dealerType,
    this.contact,
    this.creditLimit,
    this.overdueBalance,
    this.overdueHold,
    this.address,
    this.address2,
    this.city,
    this.zipcode,
    this.email,
    this.phone,
    this.fax,
    this.territory,
    this.paymentMethod,
    this.paymentTerms,
    this.cashFlowPaymentTerms,
    this.shippingMethod,
    this.structure,
    this.copySellFrom,
    this.shippingAdvice,
    this.shippingReserve,
    this.paymentApplicationMethod,
    this.billingLocationCode,
    this.generalBusinessPostingGroup,
    this.company,
    this.distributor,
    this.taxInformation,
    this.state,

  });

  int id;
  String navId;
  String name;
  int dealerType;
  String contact;
  int creditLimit;
  int overdueBalance;
  dynamic overdueHold;
  String address;
  String address2;
  String city;
  String zipcode;
  String email;
  String phone;
  dynamic fax;
  CashFlowPaymentTerms territory;
  CashFlowPaymentTerms paymentMethod;
  CashFlowPaymentTerms paymentTerms;
  CashFlowPaymentTerms cashFlowPaymentTerms;
  CashFlowPaymentTerms shippingMethod;
  BillingLocationCode structure;
  CashFlowPaymentTerms copySellFrom;
  CashFlowPaymentTerms shippingAdvice;
  CashFlowPaymentTerms shippingReserve;
  CashFlowPaymentTerms paymentApplicationMethod;
  BillingLocationCode billingLocationCode;
  CashFlowPaymentTerms generalBusinessPostingGroup;
  DealersDetsilsCompany company;
  Distributor distributor;
  TaxInformation taxInformation;
  DealerState state;


  factory DealersDetsils.fromJson(Map<String, dynamic> json) => DealersDetsils(
    id: json["id"],
    navId: json["nav_id"],
    name: json["name"],
    dealerType: json["dealer_type"],
    contact: json["contact"],
    creditLimit: json["credit_limit"],
    overdueBalance: json["overdue_balance"],
    overdueHold: json["overdue_hold"],
    address: json["address"],
    address2: json["address2"],
    city: json["city"],
    zipcode: json["zipcode"],
    email: json["email"],
    phone: json["phone"],
    fax: json["fax"],
    territory: CashFlowPaymentTerms.fromJson(json["territory"]),
    paymentMethod: CashFlowPaymentTerms.fromJson(json["paymentMethod"]),
    paymentTerms: CashFlowPaymentTerms.fromJson(json["paymentTerms"]),
    cashFlowPaymentTerms: CashFlowPaymentTerms.fromJson(json["cashFlowPaymentTerms"]),
    shippingMethod: CashFlowPaymentTerms.fromJson(json["shippingMethod"]),
    structure: BillingLocationCode.fromJson(json["structure"]),
    copySellFrom: CashFlowPaymentTerms.fromJson(json["copySellFrom"]),
    shippingAdvice: CashFlowPaymentTerms.fromJson(json["shippingAdvice"]),
    shippingReserve: CashFlowPaymentTerms.fromJson(json["shippingReserve"]),
    paymentApplicationMethod: CashFlowPaymentTerms.fromJson(json["paymentApplicationMethod"]),
    billingLocationCode: BillingLocationCode.fromJson(json["billingLocationCode"]),
    generalBusinessPostingGroup: CashFlowPaymentTerms.fromJson(json["generalBusinessPostingGroup"]),
    company: DealersDetsilsCompany.fromJson(json["company"]),
    distributor: Distributor.fromJson(json["distributor"]),
    taxInformation: TaxInformation.fromJson(json["tax_information"]),
    state: DealerState.fromJson(json["state"]),


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nav_id": navId,
    "name": name,
    "dealer_type": dealerType,
    "contact": contact,
    "credit_limit": creditLimit,
    "overdue_balance": overdueBalance,
    "overdue_hold": overdueHold,
    "address": address,
    "address2": address2,
    "city": city,
    "zipcode": zipcode,
    "email": email,
    "phone": phone,
    "fax": fax,
    "territory": territory.toJson(),
    "paymentMethod": paymentMethod.toJson(),
    "paymentTerms": paymentTerms.toJson(),
    "cashFlowPaymentTerms": cashFlowPaymentTerms.toJson(),
    "shippingMethod": shippingMethod.toJson(),
    "structure": structure.toJson(),
    "copySellFrom": copySellFrom.toJson(),
    "shippingAdvice": shippingAdvice.toJson(),
    "shippingReserve": shippingReserve.toJson(),
    "paymentApplicationMethod": paymentApplicationMethod.toJson(),
    "billingLocationCode": billingLocationCode.toJson(),
    "generalBusinessPostingGroup": generalBusinessPostingGroup.toJson(),
    "company": company.toJson(),
    "distributor": distributor.toJson(),
    "tax_information": taxInformation.toJson(),
    "state": state.toJson(),

  };
}

class BillingLocationCode {
  BillingLocationCode({
    this.code,
    this.name,
  });

  String code;
  String name;

  factory BillingLocationCode.fromJson(Map<String, dynamic> json) => BillingLocationCode(
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
  };
}

class CashFlowPaymentTerms {
  CashFlowPaymentTerms({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory CashFlowPaymentTerms.fromJson(Map<String, dynamic> json) => CashFlowPaymentTerms(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class DealersDetsilsCompany {
  DealersDetsilsCompany({
    this.id,
    this.name,
    this.database,
    this.author,
  });

  int id;
  String name;
  String database;
  Author author;

  factory DealersDetsilsCompany.fromJson(Map<String, dynamic> json) => DealersDetsilsCompany(
    id: json["id"],
    name: json["name"],
    database: json["database"],
    author: Author.fromJson(json["author"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "database": database,
    "author": author.toJson(),
  };
}

class Author {
  Author({
    this.id,
    this.name,
    this.email,
  });

  int id;
  String name;
  String email;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
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
    this.state,

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
  DealerState state;


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
    state: DealerState.fromJson(json["state"]),

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
    "state": state.toJson(),

  };
}

class DistributorCompany {
  DistributorCompany({
    this.id,
    this.name,
    this.region,
  });

  int id;
  String name;
  Region region;

  factory DistributorCompany.fromJson(Map<String, dynamic> json) => DistributorCompany(
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

class DealerState {
  DealerState({
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

  factory DealerState.fromJson(Map<String, dynamic> json) => DealerState(
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
  CashFlowPaymentTerms registrationType;
  CashFlowPaymentTerms customerType;

  factory Gst.fromJson(Map<String, dynamic> json) => Gst(
    number: json["number"],
    registrationType: CashFlowPaymentTerms.fromJson(json["registration_type"]),
    customerType: CashFlowPaymentTerms.fromJson(json["customer_type"]),
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "registration_type": registrationType.toJson(),
    "customer_type": customerType.toJson(),
  };
}

class Pan {
  Pan({
    this.referenceNumber,
    this.number,
    this.status,
  });

  dynamic referenceNumber;
  String number;
  CashFlowPaymentTerms status;

  factory Pan.fromJson(Map<String, dynamic> json) => Pan(
    referenceNumber: json["reference_number"],
    number: json["number"] == null ? null : json["number"],
    status: json["status"] == null ? null : CashFlowPaymentTerms.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "reference_number": referenceNumber,
    "number": number == null ? null : number,
    "status": status == null ? null : status.toJson(),
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
