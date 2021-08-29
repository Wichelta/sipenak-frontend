// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    @required this.code,
    @required this.id,
    @required this.success,
    @required this.message,
    @required this.token,
    @required this.tokenType,
  });

  int code;
  String id;
  bool success;
  String message;
  String token;
  String tokenType;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code: json["code"] == null ? null : json["code"],
        id: json["id"] == null ? null : json["id"],
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        token: json["token"] == null ? null : json["token"],
        tokenType: json["token_type"] == null ? null : json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "id": id == null ? null : id,
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "token": token == null ? null : token,
        "token_type": tokenType == null ? null : tokenType,
      };
}
