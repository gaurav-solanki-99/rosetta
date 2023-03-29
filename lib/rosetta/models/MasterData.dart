class MasterData {
  List<ShippingReserve> shippingReserve;
  List<ShippingMethod> shippingMethod;
  // List<ShippingAdvice> shippingAdvice;
  // List<PaymentApplicationMethod> paymentApplicationMethod;
  List<PaymentMethod> paymentMethod;
  List<PaymentTerms> paymentTerms;
  // List<CashFlowPaymentTerms> cashFlowPaymentTerms;
  // List<GenBusPostinGrp> genBusPostinGrp;
  // List<SellToAddr> sellToAddr;
  // List<BaseUnitOfMeasure> baseUnitOfMeasure;
  // List<PurchaseUnitOfMeasure> purchaseUnitOfMeasure;
  // List<SalesUnitOfMeasure> salesUnitOfMeasure;
  // List<ItemTrackingCode> itemTrackingCode;
  // List<ReorderPolicy> reorderPolicy;
  // List<TaxGrpCode> taxGrpCode;
  // List<TerritoryCode> territoryCode;

  MasterData(
      {this.shippingReserve,
        this.shippingMethod,
        // this.shippingAdvice,
        // this.paymentApplicationMethod,
        this.paymentMethod,
        // this.paymentTerms,
        // this.cashFlowPaymentTerms,
        // this.genBusPostinGrp,
        // this.sellToAddr,
        // this.baseUnitOfMeasure,
        // this.purchaseUnitOfMeasure,
        // this.salesUnitOfMeasure,
        // this.itemTrackingCode,
        // this.reorderPolicy,
        // this.taxGrpCode,
        // this.territoryCode

      });

  MasterData.fromJson(Map<String, dynamic> json) {
    if (json['shipping_reserve'] != null) {
      shippingReserve = <ShippingReserve>[];
      json['shipping_reserve'].forEach((v) {
        shippingReserve.add(new ShippingReserve.fromJson(v));
      });
    }
    if (json['shipping_method'] != null) {
      shippingMethod = <ShippingMethod>[];
      json['shipping_method'].forEach((v) {
        shippingMethod.add(new ShippingMethod.fromJson(v));
      });
    }
    // if (json['shipping_advice'] != null) {
    //   shippingAdvice = <ShippingAdvice>[];
    //   json['shipping_advice'].forEach((v) {
    //     shippingAdvice!.add(new ShippingAdvice.fromJson(v));
    //   });
    // }
    // if (json['payment_application_method'] != null) {
    //   paymentApplicationMethod = <PaymentApplicationMethod>[];
    //   json['payment_application_method'].forEach((v) {
    //     paymentApplicationMethod!.add(new PaymentApplicationMethod.fromJson(v));
    //   });
    // }
    if (json['payment_method'] != null) {
      paymentMethod = <PaymentMethod>[];
      json['payment_method'].forEach((v) {
        paymentMethod.add(new PaymentMethod.fromJson(v));
      });
    }
    if (json['payment_terms'] != null) {
      paymentTerms = <PaymentTerms>[];
      json['payment_terms'].forEach((v) {
        paymentTerms.add(new PaymentTerms.fromJson(v));
      });
    }
    // if (json['cash_flow_payment_terms'] != null) {
    //   cashFlowPaymentTerms = <CashFlowPaymentTerms>[];
    //   json['cash_flow_payment_terms'].forEach((v) {
    //     cashFlowPaymentTerms!.add(new CashFlowPaymentTerms.fromJson(v));
    //   });
    // }
    // if (json['gen_bus_postin_grp'] != null) {
    //   genBusPostinGrp = <GenBusPostinGrp>[];
    //   json['gen_bus_postin_grp'].forEach((v) {
    //     genBusPostinGrp!.add(new GenBusPostinGrp.fromJson(v));
    //   });
    // }
    // if (json['sell_to_addr'] != null) {
    //   sellToAddr = <SellToAddr>[];
    //   json['sell_to_addr'].forEach((v) {
    //     sellToAddr!.add(new SellToAddr.fromJson(v));
    //   });
    // }
    // if (json['base_unit_of_measure'] != null) {
    //   baseUnitOfMeasure = <BaseUnitOfMeasure>[];
    //   json['base_unit_of_measure'].forEach((v) {
    //     baseUnitOfMeasure!.add(new BaseUnitOfMeasure.fromJson(v));
    //   });
    // }
    // if (json['purchase_unit_of_measure'] != null) {
    //   purchaseUnitOfMeasure = <PurchaseUnitOfMeasure>[];
    //   json['purchase_unit_of_measure'].forEach((v) {
    //     purchaseUnitOfMeasure!.add(new PurchaseUnitOfMeasure.fromJson(v));
    //   });
    // }
    // if (json['sales_unit_of_measure'] != null) {
    //   salesUnitOfMeasure = <SalesUnitOfMeasure>[];
    //   json['sales_unit_of_measure'].forEach((v) {
    //     salesUnitOfMeasure!.add(new SalesUnitOfMeasure.fromJson(v));
    //   });
    // }
    // if (json['item_tracking_code'] != null) {
    //   itemTrackingCode = <ItemTrackingCode>[];
    //   json['item_tracking_code'].forEach((v) {
    //     itemTrackingCode!.add(new ItemTrackingCode.fromJson(v));
    //   });
    // }
    // if (json['reorder_policy'] != null) {
    //   reorderPolicy = <ReorderPolicy>[];
    //   json['reorder_policy'].forEach((v) {
    //     reorderPolicy!.add(new ReorderPolicy.fromJson(v));
    //   });
    // }
    // if (json['tax_grp_code'] != null) {
    //   taxGrpCode = <TaxGrpCode>[];
    //   json['tax_grp_code'].forEach((v) {
    //     taxGrpCode!.add(new TaxGrpCode.fromJson(v));
    //   });
    // }
    // if (json['territory_code'] != null) {
    //   territoryCode = <TerritoryCode>[];
    //   json['territory_code'].forEach((v) {
    //     territoryCode!.add(new TerritoryCode.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippingReserve != null) {
      data['shipping_reserve'] =
          this.shippingReserve.map((v) => v.toJson()).toList();
    }
    if (this.shippingMethod != null) {
      data['shipping_method'] =
          this.shippingMethod.map((v) => v.toJson()).toList();
    }
    // if (this.shippingAdvice != null) {
    //   data['shipping_advice'] =
    //       this.shippingAdvice!.map((v) => v.toJson()).toList();
    // }
    // if (this.paymentApplicationMethod != null) {
    //   data['payment_application_method'] =
    //       this.paymentApplicationMethod!.map((v) => v.toJson()).toList();
    // }
    if (this.paymentMethod != null) {
      data['payment_method'] =
          this.paymentMethod.map((v) => v.toJson()).toList();
    }
    if (this.paymentTerms != null) {
      data['payment_terms'] =
          this.paymentTerms.map((v) => v.toJson()).toList();
    }
    // if (this.cashFlowPaymentTerms != null) {
    //   data['cash_flow_payment_terms'] =
    //       this.cashFlowPaymentTerms!.map((v) => v.toJson()).toList();
    // }
    // if (this.genBusPostinGrp != null) {
    //   data['gen_bus_postin_grp'] =
    //       this.genBusPostinGrp!.map((v) => v.toJson()).toList();
    // }
    // if (this.sellToAddr != null) {
    //   data['sell_to_addr'] = this.sellToAddr!.map((v) => v.toJson()).toList();
    // }
    // if (this.baseUnitOfMeasure != null) {
    //   data['base_unit_of_measure'] =
    //       this.baseUnitOfMeasure!.map((v) => v.toJson()).toList();
    // }
    // if (this.purchaseUnitOfMeasure != null) {
    //   data['purchase_unit_of_measure'] =
    //       this.purchaseUnitOfMeasure!.map((v) => v.toJson()).toList();
    // }
    // if (this.salesUnitOfMeasure != null) {
    //   data['sales_unit_of_measure'] =
    //       this.salesUnitOfMeasure!.map((v) => v.toJson()).toList();
    // }
    // if (this.itemTrackingCode != null) {
    //   data['item_tracking_code'] =
    //       this.itemTrackingCode!.map((v) => v.toJson()).toList();
    // }
    // if (this.reorderPolicy != null) {
    //   data['reorder_policy'] =
    //       this.reorderPolicy!.map((v) => v.toJson()).toList();
    // }
    // if (this.taxGrpCode != null) {
    //   data['tax_grp_code'] = this.taxGrpCode!.map((v) => v.toJson()).toList();
    // }
    // if (this.territoryCode != null) {
    //   data['territory_code'] =
    //       this.territoryCode!.map((v) => v.toJson()).toList();
    // }


    return data;
  }
}

class ShippingReserve {
  String type;
  String key;
  String value;
  int sort;

  ShippingReserve({this.type, this.key, this.value, this.sort});

  ShippingReserve.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    key = json['key'];
    value = json['value'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['key'] = this.key;
    data['value'] = this.value;
    data['sort'] = this.sort;
    return data;
  }
}
class ShippingMethod {
  String type;
  String key;
  String value;
  int sort;

  ShippingMethod({this.type, this.key, this.value, this.sort});

  ShippingMethod.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    key = json['key'];
    value = json['value'];
    sort = json['sort'];
  }




  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['key'] = this.key;
    data['value'] = this.value;
    data['sort'] = this.sort;
    return data;
  }
}
class PaymentMethod {
  String type;
  String key;
  String value;
  int sort;

  PaymentMethod({this.type, this.key, this.value, this.sort});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    key = json['key'];
    value = json['value'];
    sort = json['sort'];
  }




  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['key'] = this.key;
    data['value'] = this.value;
    data['sort'] = this.sort;
    return data;
  }
}
class PaymentTerms {
  String type;
  String key;
  String value;
  int sort;

  PaymentTerms({this.type, this.key, this.value, this.sort});

  PaymentTerms.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    key = json['key'];
    value = json['value'];
    sort = json['sort'];
  }




  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['key'] = this.key;
    data['value'] = this.value;
    data['sort'] = this.sort;
    return data;
  }
}
