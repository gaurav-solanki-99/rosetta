// To parse this JSON data, do
//
//     final spinnerDealerRefined = spinnerDealerRefinedFromJson(jsonString);

import 'dart:convert';

List<SpinnerDealerRefined> spinnerDealerRefinedFromJson(String str) => List<SpinnerDealerRefined>.from(json.decode(str).map((x) => SpinnerDealerRefined.fromJson(x)));

String spinnerDealerRefinedToJson(List<SpinnerDealerRefined> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpinnerDealerRefined {
  SpinnerDealerRefined({
    this.id,
    this.navId,
    this.name,
    this.type,
    this.distributorId,
  });

  int id;
  String navId;
  String name;
  Type type;
  int distributorId;

  factory SpinnerDealerRefined.fromJson(Map<String, dynamic> json) => SpinnerDealerRefined(
    id: json["id"],
    navId: json["nav_id"],
    name: json["name"],
    type: typeValues.map[json["type"]],
    distributorId: json["distributor_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nav_id": navId,
    "name": name,
    "type": typeValues.reverse[type],
    "distributor_id": distributorId,
  };
}

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
