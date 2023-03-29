import 'dart:convert';

ForceUpdate forceUpdateFromJson(String str) => ForceUpdate.fromJson(json.decode(str));

String forceUpdateToJson(ForceUpdate data) => json.encode(data.toJson());

class ForceUpdate {
  ForceUpdate({
    this.status,
    this.appVersion,
    this.deviceType,
    this.forceUpdate,
  });

  bool status;
  String appVersion;
  String deviceType;
  String forceUpdate;

  factory ForceUpdate.fromJson(Map<String, dynamic> json) => ForceUpdate(
    status: json["status"],
    appVersion: json["app_version"],
    deviceType: json["device_type"],
    forceUpdate: json["force_update"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "app_version": appVersion,
    "device_type": deviceType,
    "force_update": forceUpdate,
  };
}