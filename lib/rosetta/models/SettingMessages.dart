
import 'dart:convert';

SettingMessages settingMessagesFromJson(String str) => SettingMessages.fromJson(json.decode(str));

String settingMessagesToJson(SettingMessages data) => json.encode(data.toJson());

class SettingMessages {
  SettingMessages({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory SettingMessages.fromJson(Map<String, dynamic> json) => SettingMessages(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
