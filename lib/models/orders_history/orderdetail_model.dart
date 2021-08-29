// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  OrderDetailModel({
    @required this.id,
    @required this.productName,
    @required this.price,
    @required this.unit,
    @required this.quantity,
    @required this.totalProductPrice,
    @required this.orderId,
    @required this.product,
  });

  int id;
  String productName;
  int price;
  String unit;
  int quantity;
  int totalProductPrice;
  String orderId;
  int product;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        unit: json["unit"],
        quantity: json["quantity"],
        totalProductPrice: json["total_product_price"],
        orderId: json["order_id"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "unit": unit,
        "quantity": quantity,
        "total_product_price": totalProductPrice,
        "order_id": orderId,
        "product": product,
      };
}
