// To parse this JSON data, do
//
//     final orderProductModel = orderProductModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderProductModel orderProductModelFromJson(String str) =>
    OrderProductModel.fromJson(json.decode(str));

String orderProductModelToJson(OrderProductModel data) =>
    json.encode(data.toJson());

class OrderProductModel {
  OrderProductModel({
    @required this.id,
    @required this.productName,
    @required this.quantity,
    @required this.totalProductPrice,
    @required this.orderId,
    @required this.product,
  });

  int id;
  String productName;
  int quantity;
  int totalProductPrice;
  String orderId;
  int product;

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      OrderProductModel(
        id: json["id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        totalProductPrice: json["total_product_price"],
        orderId: json["order_id"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "quantity": quantity,
        "total_product_price": totalProductPrice,
        "order_id": orderId,
        "product": product,
      };
}
