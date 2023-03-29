// To parse this JSON data, do
//
//     final dashBoardData = dashBoardDataFromJson(jsonString);

import 'dart:convert';

DashBoardData dashBoardDataFromJson(String str) => DashBoardData.fromJson(json.decode(str));

String dashBoardDataToJson(DashBoardData data) => json.encode(data.toJson());

class DashBoardData {
  DashBoardData({
    this.tiles,
    this.monthly,
  });

  List<Tile> tiles;
  List<Monthly> monthly;

  factory DashBoardData.fromJson(Map<String, dynamic> json) => DashBoardData(
    tiles: List<Tile>.from(json["tiles"].map((x) => Tile.fromJson(x))),
    monthly: List<Monthly>.from(json["monthly"].map((x) => Monthly.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tiles": List<dynamic>.from(tiles.map((x) => x.toJson())),
    "monthly": List<dynamic>.from(monthly.map((x) => x.toJson())),
  };
}

class Monthly {
  Monthly({
    this.title,
    this.value,
    this.type,
    this.icon,
    this.colour,
  });

  String title;
  var value;
  String type;
  String icon;
  String colour;

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
    title: json["title"],
    value: json["value"],
    type: json["type"],
    icon: json["icon"],
    colour: json["colour"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value,
    "type": type,
    "icon": icon,
    "colour": colour,
  };
}

class Tile {
  Tile({
    this.title,
    this.value,
    this.type,
    this.icon,
    this.colour,
  });

  String title;
  var value;
  String type;
  String icon;
  String colour;

  factory Tile.fromJson(Map<String, dynamic> json) => Tile(
    title: json["title"],
    value: json["value"],
    type: json["type"],
    icon: json["icon"],
    colour: json["colour"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value,
    "type": type,
    "icon": icon,
    "colour": colour,
  };
}
