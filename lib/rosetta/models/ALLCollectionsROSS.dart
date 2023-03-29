// To parse this JSON data, do
//
//     final allRossCollectionsRoss = allRossCollectionsRossFromJson(jsonString);

import 'dart:convert';

List<AllRossCollectionsRoss> allRossCollectionsRossFromJson(String str) => List<AllRossCollectionsRoss>.from(json.decode(str).map((x) => AllRossCollectionsRoss.fromJson(x)));

String allRossCollectionsRossToJson(List<AllRossCollectionsRoss> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllRossCollectionsRoss {
  AllRossCollectionsRoss({
    this.code,
    this.display,
    this.collections,
  });

  String code;
  String display;
  List<RossCollections> collections;

  factory AllRossCollectionsRoss.fromJson(Map<String, dynamic> json) => AllRossCollectionsRoss(
    code: json["code"],
    display: json["display"],
    collections: List<RossCollections>.from(json["collections"].map((x) => RossCollections.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display": display,
    "collections": List<dynamic>.from(collections.map((x) => x.toJson())),
  };
}

class RossCollections {
  RossCollections({
    this.code,
    this.display,
    this.colours,
  });

  String code;
  String display;
  List<RossColours> colours;

  factory RossCollections.fromJson(Map<String, dynamic> json) => RossCollections(
    code: json["code"],
    display: json["display"],
    colours: List<RossColours>.from(json["colours"].map((x) => RossColours.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display": display,
    "colours": List<dynamic>.from(colours.map((x) => x.toJson())),
  };
}

class RossColours {
  RossColours({
    this.code,
    this.display,
  });

  String code;
  String display;

  factory RossColours.fromJson(Map<String, dynamic> json) => RossColours(
    code: json["code"],
    display: json["display"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "display": display,
  };
}
