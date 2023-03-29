// To parse this JSON data, do
//
//     final skipButtonApi = skipButtonApiFromJson(jsonString);

import 'dart:convert';

SkipButtonApi skipButtonApiFromJson(String str) => SkipButtonApi.fromJson(json.decode(str));

String skipButtonApiToJson(SkipButtonApi data) => json.encode(data.toJson());

class SkipButtonApi {
  SkipButtonApi({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory SkipButtonApi.fromJson(Map<String, dynamic> json) => SkipButtonApi(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
