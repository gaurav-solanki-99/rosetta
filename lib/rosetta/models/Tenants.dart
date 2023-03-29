// To parse this JSON data, do
//
//     final tenants = tenantsFromJson(jsonString);

import 'dart:convert';

List<Tenants> tenantsFromJson(String str) => List<Tenants>.from(json.decode(str).map((x) => Tenants.fromJson(x)));

String tenantsToJson(List<Tenants> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tenants {
  Tenants({
    this.name,
    this.url,
  });

  String name;
  String url;

  factory Tenants.fromJson(Map<String, dynamic> json) => Tenants(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}
