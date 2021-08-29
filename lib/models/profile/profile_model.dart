// To parse this JSON data, do
//
//     final dataProfileModel = dataProfileModelFromJson(jsonString);
import 'package:meta/meta.dart';
import 'dart:convert';

DataProfileModel dataProfileModelFromJson(String str) =>
    DataProfileModel.fromJson(json.decode(str));

String dataProfileModelToJson(DataProfileModel data) =>
    json.encode(data.toJson());

class DataProfileModel {
  DataProfileModel({
    @required this.code,
    @required this.message,
    @required this.success,
    @required this.data,
  });

  int code;
  String message;
  bool success;
  Data data;

  factory DataProfileModel.fromJson(Map<String, dynamic> json) =>
      DataProfileModel(
        code: json["code"],
        message: json["message"],
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    @required this.id,
    @required this.nikKtp,
    @required this.fullName,
    @required this.email,
    @required this.phoneNumber,
    @required this.address,
    @required this.profilePhoto,
    @required this.ktpPhoto,
    @required this.verificationStatus,
  });

  int id;
  String nikKtp;
  String fullName;
  String email;
  String phoneNumber;
  String address;
  dynamic profilePhoto;
  dynamic ktpPhoto;
  String verificationStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nikKtp: json["nik_ktp"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        profilePhoto: json["profile_photo"],
        ktpPhoto: json["ktp_photo"],
        verificationStatus: json["verification_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik_ktp": nikKtp,
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "profile_photo": profilePhoto,
        "ktp_photo": ktpPhoto,
        "verification_status": verificationStatus,
      };
}
