// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    @required this.id,
    @required this.category,
    @required this.productName,
    @required this.productPhoto,
    @required this.description,
    @required this.unit,
    @required this.price,
    @required this.stock,
    @required this.location,
    @required this.available,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String category;
  String productName;
  String productPhoto;
  String description;
  String unit;
  int price;
  int stock;
  String location;
  bool available;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        category: json["category"],
        productName: json["product_name"],
        productPhoto: json["product_photo"],
        description: json["description"],
        unit: json["unit"],
        price: json["price"],
        stock: json["stock"],
        location: json["location"],
        available: json["available"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "product_name": productName,
        "product_photo": productPhoto,
        "description": description,
        "unit": unit,
        "price": price,
        "stock": stock,
        "location": location,
        "available": available,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
