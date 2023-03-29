import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShAddress.dart';
import  'package:rosetta_fluter_app/rosetta/models/ShAttribute.dart';
import  'package:rosetta_fluter_app/rosetta/models/ShCategory.dart';
import  'package:rosetta_fluter_app/rosetta/models/ShOrder.dart';
import  'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';

Future<String> loadContentAsset(String path) async {
  return await rootBundle.loadString(path);
}

Future<List<ShCategory>> loadCategory() async {
  String jsonString = await loadContentAsset('assets/shophop_data/category.json');
  final jsonResponse = json.decode(jsonString);
  return (jsonResponse as List).map((i) => ShCategory.fromJson(i)).toList();
}

Future<List<ShProduct>> loadProducts() async {
  String jsonString = await loadContentAsset('assets/shophop_data/products.json');
  final jsonResponse = json.decode(jsonString);
  return (jsonResponse as List).map((i) => ShProduct.fromJson(i)).toList();
}









Future<List<String>> loadBanners() async {
  List<ShProduct> products = await loadProducts();
  List<String> banner = [];

  products.forEach((product) {
    if (product.images.isNotEmpty) {
      banner.add("images/shophop/img/products" + product.images[0].src);
    }
  });
  return banner;
}

extension StringExtension on String {
  String toCurrencyFormat({var format = '\₹'}) {
    return format + this;
  }

  String formatDateTime() {
    if (this == null || this.isEmpty || this == "null") {
      return "NA";
    } else {
      return DateFormat("HH:mm dd MMM yyyy", "en_US").format(DateFormat("yyyy-MM-dd HH:mm:ss.0", "en_US").parse(this));
    }
  }

  String formatDate() {
    if (this == null || this.isEmpty || this == "null") {
      return "NA";
    } else {
      return DateFormat("dd MMM yyyy", "en_US").format(DateFormat("yyyy-MM-dd", "en_US").parse(this));
    }
  }
}
