// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String email;
  String uid;
  String employeeCode;
  String area;
  bool isLoginAllowed;
  bool isAdmin;
  String profilePictureUrl;
  bool notifications;

  UserModel({
    this.name = '',
    this.email = '',
    this.uid = '',
    this.employeeCode = '',
    this.area = '',
    this.isLoginAllowed = true,
    this.isAdmin = false,
    this.profilePictureUrl = '',
    this.notifications = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        uid: json["uid"],
        employeeCode: json["employeeCode"],
        area: json["area"],
        isLoginAllowed: json["isLoginAllowed"],
        isAdmin: json["isAdmin"],
        profilePictureUrl: json["profilePictureUrl"],
        notifications: json["notifications"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "employeeCode": employeeCode,
        "area": area,
        "isLoginAllowed": isLoginAllowed,
        "isAdmin": isAdmin,
        "profilePictureUrl": profilePictureUrl,
        "notifications": notifications,
      };
}
