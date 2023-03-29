import 'dart:convert';

CooolingDown cooolingDownFromJson(String str) => CooolingDown.fromJson(json.decode(str));

String cooolingDownToJson(CooolingDown data) => json.encode(data.toJson());

class CooolingDown {
  CooolingDown({
    this.key,
    this.error,
    this.until,
  });

  String key;
  String error;
  String until;

  factory CooolingDown.fromJson(Map<String, dynamic> json) => CooolingDown(
    key: json["key"],
    error: json["error"],
    until: json["until"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "error": error,
    "until": until,
  };
}
