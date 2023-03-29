// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.changePassword,
    this.memberType,
    this.memberId,
    this.memberName,
    this.memberNavId,
    this.companyId,
    this.regionId,
    this.allowAddToCart,
    this.allowBlock,
    this.allowAdvanceOrdering,
    this.parentDistributorId,
    this.parentDistributorNavId,
    this.parentDistributorName,
    this.token,
  });

  int id;
  String name;
  String email;
  String createdAt;
  String updatedAt;
  bool changePassword;
  String memberType;
  int memberId;
  String memberName;
  String memberNavId;
  int companyId;
  int regionId;
  bool allowAddToCart;
  bool allowBlock;
  bool allowAdvanceOrdering;
  var parentDistributorId;
  var parentDistributorNavId;
  String parentDistributorName;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    changePassword: json["change_password"],
    memberType: json["member_type"],
    memberId: json["member_id"],
    memberName: json["member_name"],
    memberNavId: json["member_nav_id"],
    companyId: json["company_id"],
    regionId: json["region_id"],
    allowAddToCart: json["allow_add_to_cart"],
    allowBlock: json["allow_block"],
    allowAdvanceOrdering: json["allow_advance_ordering"],
    parentDistributorId: json["parent_distributor_id"],
    parentDistributorNavId: json["parent_distributor_nav_id"],
    parentDistributorName: json["parent_distributor_name"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "change_password": changePassword,
    "member_type": memberType,
    "member_id": memberId,
    "member_name": memberName,
    "member_nav_id": memberNavId,
    "company_id": companyId,
    "region_id": regionId,
    "parent_distributor_id": parentDistributorId,
    "parent_distributor_nav_id": parentDistributorNavId,
    "parent_distributor_name": parentDistributorName,
    "allow_add_to_cart": allowAddToCart,
    "allow_block": allowBlock,
    "allow_advance_ordering": allowAdvanceOrdering,
    "token": token,
  };
}
