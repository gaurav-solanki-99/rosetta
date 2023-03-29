// To parse this JSON data, do
//
//     final poDetailsObjectDetails = poDetailsObjectDetailsFromJson(jsonString);

import 'dart:convert';

PoDetailsObjectDetails poDetailsObjectDetailsFromJson(String str) => PoDetailsObjectDetails.fromJson(json.decode(str));

String poDetailsObjectDetailsToJson(PoDetailsObjectDetails data) => json.encode(data.toJson());

class PoDetailsObjectDetails {
  PoDetailsObjectDetails({
    this.po,
    this.alert,
  });

  PoDetailsObject po;
  var alert;

  factory PoDetailsObjectDetails.fromJson(Map<String, dynamic> json) => PoDetailsObjectDetails(
    po: PoDetailsObject.fromJson(json["po"]),
    alert: json["alert"],
  );

  Map<String, dynamic> toJson() => {
    "po": po.toJson(),
    "alert": alert,
  };
}

class PoDetailsObject {
  PoDetailsObject({
    this.id,
    this.number,
    this.amount,
    this.createdAt,
    this.status,
    this.customerType,
    this.distributorId,
    this.remainingAmount,
    this.paidAmount,
    this.shipped,
    this.allCompanyLinesShipped,
    this.allCodistributorLinesShipped,
    this.invoiceId,
    this.rosInvoiceNumber,
    this.navInvoiceNumber,
    this.customer,
    this.address,
    this.purchaseLines,
  });

  int id;
  String number;
  double amount;
  String createdAt;
  String status;
  String customerType;
  dynamic distributorId;
  double remainingAmount;
  int paidAmount;
  bool shipped;
  bool allCompanyLinesShipped;
  bool allCodistributorLinesShipped;
  dynamic invoiceId;
  dynamic rosInvoiceNumber;
  String navInvoiceNumber;
  Customer customer;
  Address address;
  List<PurchaseLine> purchaseLines;

  factory PoDetailsObject.fromJson(Map<String, dynamic> json) => PoDetailsObject(
    id: json["id"],
    number: json["number"],
    amount: json["amount"].toDouble(),
    createdAt: json["created_at"],
    status: json["status"],
    customerType: json["customer_type"],
    distributorId: json["distributor_id"],
    remainingAmount: json["remaining_amount"].toDouble(),
    paidAmount: json["paid_amount"],
    shipped: json["shipped"],
    allCompanyLinesShipped: json["all_company_lines_shipped"],
    allCodistributorLinesShipped: json["all_codistributor_lines_shipped"],
    invoiceId: json["invoice_id"],
    rosInvoiceNumber: json["ros_invoice_number"],
    navInvoiceNumber: json["nav_invoice_number"],
    customer: Customer.fromJson(json["customer"]),
    address: Address.fromJson(json["address"]),
    purchaseLines: List<PurchaseLine>.from(json["purchase_lines"].map((x) => PurchaseLine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "amount": amount,
    "created_at": createdAt,
    "status": status,
    "customer_type": customerType,
    "distributor_id": distributorId,
    "remaining_amount": remainingAmount,
    "paid_amount": paidAmount,
    "shipped": shipped,
    "all_company_lines_shipped": allCompanyLinesShipped,
    "all_codistributor_lines_shipped": allCodistributorLinesShipped,
    "invoice_id": invoiceId,
    "ros_invoice_number": rosInvoiceNumber,
    "nav_invoice_number": navInvoiceNumber,
    "customer": customer.toJson(),
    "address": address.toJson(),
    "purchase_lines": List<dynamic>.from(purchaseLines.map((x) => x.toJson())),
  };
}

class Address {
  Address({
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

  String address;
  dynamic address2;
  String postCode;
  String city;
  String countryRegionCode;
  String phoneNo;
  String name;
  String contact;
  dynamic state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    address2: json["address_2"],
    postCode: json["post_code"],
    city: json["city"],
    countryRegionCode: json["country_region_code"],
    phoneNo: json["phone_no"],
    name: json["name"],
    contact: json["contact"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "address_2": address2,
    "post_code": postCode,
    "city": city,
    "country_region_code": countryRegionCode,
    "phone_no": phoneNo,
    "name": name,
    "contact": contact,
    "state": state,
  };
}

class Customer {
  Customer({
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
    this.state,
  });

  int id;
  String navId;
  String name;
  String contact;
  String type;
  dynamic distributorId;
  dynamic address;
  dynamic address2;
  String city;
  dynamic zipcode;
  String email;
  String phone;
  dynamic fax;
  PaymentTerms paymentTerms;
  Company company;
  TaxInformation taxInformation;
  States state;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
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
    paymentTerms: PaymentTerms.fromJson(json["paymentTerms"])==null?null:PaymentTerms.fromJson(json["paymentTerms"]),
    company: Company.fromJson(json["company"]),
    taxInformation: TaxInformation.fromJson(json["tax_information"]),
    state: States.fromJson(json["state"]),
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
    "state": state.toJson(),
  };
}

class Company {
  Company({
    this.id,
    this.name,
    this.region,
  });

  int id;
  String name;
  Region region;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
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

class PaymentTerms {
  PaymentTerms({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory PaymentTerms.fromJson(Map<String, dynamic> json) => PaymentTerms(
    key: json["key"]==null?null:json["key"],
    value: json["value"]==null?null:json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
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

  dynamic number;
  PaymentTerms registrationType;
  dynamic customerType;

  factory Gst.fromJson(Map<String, dynamic> json) => Gst(
    number: json["number"],
    registrationType: PaymentTerms.fromJson(json["registration_type"]),
    customerType: json["customer_type"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "registration_type": registrationType.toJson(),
    "customer_type": customerType,
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

  dynamic lst;
  dynamic cst;

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    lst: json["lst"],
    cst: json["cst"],
  );

  Map<String, dynamic> toJson() => {
    "lst": lst,
    "cst": cst,
  };
}

class PurchaseLine {
  PurchaseLine({
    this.id,
    this.quantity,
    this.shippedQuantity,
    this.receivedQuantity,
    this.unitPrice,
    this.discount,
    this.rateType,
    this.amount,
    this.batchNo,
    this.returnRequested,
    this.returnApproved,
    this.returnPending,
    this.returnRejected,
    this.createdAt,
    this.purchaseOrderId,
    this.orderNumber,
    this.orderStatus,
    this.remainingAmount,
    this.paidAmount,
    this.taxAmount,
    this.netAmount,
    this.taxTypeCode,
    this.taxPercent,
    this.returnAllowed,
    this.stockPointCode,
    this.navisionOrderNumber,
    this.product,
    this.returnItems,
    this.stockPoint,
  });

  int id;
  var quantity;
  var shippedQuantity;
  var receivedQuantity;
  double unitPrice;
  var discount;
  String rateType;
  double amount;
  String batchNo;
  int returnRequested;
  int returnApproved;
  int returnPending;
  int returnRejected;
  String createdAt;
  int purchaseOrderId;
  String orderNumber;
  String orderStatus;
  double remainingAmount;
  int paidAmount;
  double taxAmount;
  double netAmount;
  String taxTypeCode;
  int taxPercent;
  bool returnAllowed;
  String stockPointCode;
  String navisionOrderNumber;
  Product product;
  List<dynamic> returnItems;
  StockPoint stockPoint;

  factory PurchaseLine.fromJson(Map<String, dynamic> json) => PurchaseLine(
    id: json["id"],
    quantity: json["quantity"],
    shippedQuantity: json["shipped_quantity"],
    receivedQuantity: json["received_quantity"],
    unitPrice: json["unit_price"].toDouble(),
    discount: json["discount"],
    rateType: json["rate_type"],
    amount: json["amount"].toDouble(),
    batchNo: json["batch_no"],
    returnRequested: json["return_requested"],
    returnApproved: json["return_approved"],
    returnPending: json["return_pending"],
    returnRejected: json["return_rejected"],
    createdAt: json["created_at"],
    purchaseOrderId: json["purchase_order_id"],
    orderNumber: json["order_number"],
    orderStatus: json["order_status"],
    remainingAmount: json["remaining_amount"].toDouble(),
    paidAmount: json["paid_amount"],
    taxAmount: json["tax_amount"].toDouble(),
    netAmount: json["net_amount"].toDouble(),
    taxTypeCode: json["tax_type_code"],
    taxPercent: json["tax_percent"],
    returnAllowed: json["return_allowed"],
    stockPointCode: json["stock_point_code"],
    navisionOrderNumber: json["navision_order_number"],
    product: Product.fromJson(json["product"]),
    returnItems: List<dynamic>.from(json["returnItems"].map((x) => x)),
    stockPoint: StockPoint.fromJson(json["stock_point"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "shipped_quantity": shippedQuantity,
    "received_quantity": receivedQuantity,
    "unit_price": unitPrice,
    "discount": discount,
    "rate_type": rateType,
    "amount": amount,
    "batch_no": batchNo,
    "return_requested": returnRequested,
    "return_approved": returnApproved,
    "return_pending": returnPending,
    "return_rejected": returnRejected,
    "created_at": createdAt,
    "purchase_order_id": purchaseOrderId,
    "order_number": orderNumber,
    "order_status": orderStatus,
    "remaining_amount": remainingAmount,
    "paid_amount": paidAmount,
    "tax_amount": taxAmount,
    "net_amount": netAmount,
    "tax_type_code": taxTypeCode,
    "tax_percent": taxPercent,
    "return_allowed": returnAllowed,
    "stock_point_code": stockPointCode,
    "navision_order_number": navisionOrderNumber,
    "product": product.toJson(),
    "returnItems": List<dynamic>.from(returnItems.map((x) => x)),
    "stock_point": stockPoint.toJson(),
  };
}

class Product {
  Product({
    this.id,
    this.navId,
    this.name,
    this.baseUnitOfMeasure,
    this.imageUrl,
    this.category,
    this.collection,
    this.colour,
  });

  int id;
  String navId;
  String name;
  String baseUnitOfMeasure;
  dynamic imageUrl;
  Category category;
  Col collection;
  Col colour;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    navId: json["nav_id"],
    name: json["name"],
    baseUnitOfMeasure: json["base_unit_of_measure"],
    imageUrl: json["image_url"],
    category: Category.fromJson(json["category"]),
    collection: Col.fromJson(json["collection"]),
    colour: Col.fromJson(json["colour"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nav_id": navId,
    "name": name,
    "base_unit_of_measure": baseUnitOfMeasure,
    "image_url": imageUrl,
    "category": category.toJson(),
    "collection": collection.toJson(),
    "colour": colour.toJson(),
  };
}

class Category {
  Category({
    this.code,
    this.displayName,
    this.description,
    this.allowCl,
    this.clPercent,
    this.inMultiples,
    this.plankSize,
  });

  String code;
  String displayName;
  String description;
  bool allowCl;
  var clPercent;
  var inMultiples;
  var plankSize;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    code: json["code"],
    displayName: json["display_name"],
    description: json["description"],
    allowCl: json["allow_cl"],
    clPercent: json["cl_percent"],
    inMultiples: json["in_multiples"],
    plankSize: json["plank_size"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display_name": displayName,
    "description": description,
    "allow_cl": allowCl,
    "cl_percent": clPercent,
    "in_multiples": inMultiples,
    "plank_size": plankSize,
  };
}

class Col {
  Col({
    this.code,
    this.displayName,
    this.description,
    this.inMultiples,
    this.categoryCode,
    this.plankSize,
  });

  String code;
  String displayName;
  String description;
  var inMultiples;
  String categoryCode;
  var plankSize;

  factory Col.fromJson(Map<String, dynamic> json) => Col(
    code: json["code"],
    displayName: json["display_name"],
    description: json["description"] == null ? null : json["description"],
    inMultiples: json["in_multiples"],
    categoryCode: json["category_code"] == null ? null : json["category_code"],
    plankSize: json["plank_size"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display_name": displayName,
    "description": description == null ? null : description,
    "in_multiples": inMultiples,
    "category_code": categoryCode == null ? null : categoryCode,
    "plank_size": plankSize,
  };
}

class StockPoint {
  StockPoint({
    this.id,
    this.code,
    this.name,
  });

  int id;
  String code;
  String name;

  factory StockPoint.fromJson(Map<String, dynamic> json) => StockPoint(
    id: json["id"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
  };
}
