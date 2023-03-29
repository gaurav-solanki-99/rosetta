// To parse this JSON data, do
//
//     final pdfResponse = pdfResponseFromJson(jsonString);

import 'dart:convert';

PdfResponse pdfResponseFromJson(String str) => PdfResponse.fromJson(json.decode(str));

String pdfResponseToJson(PdfResponse data) => json.encode(data.toJson());

class PdfResponse {
  PdfResponse({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  String data;

  factory PdfResponse.fromJson(Map<String, dynamic> json) => PdfResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
