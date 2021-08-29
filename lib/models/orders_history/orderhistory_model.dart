// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryModel {
  OrderHistoryModel({
    @required this.orderId,
    @required this.totalPrice,
    @required this.note,
    @required this.orderStatus,
    @required this.rejectReason,
    @required this.createdAt,
    @required this.orderCompleteAt,
    @required this.transactionPhoto,
    @required this.transactionNote,
    @required this.customer,
  });

  String orderId;
  int totalPrice;
  String note;
  String orderStatus;
  String rejectReason;
  DateTime createdAt;
  dynamic orderCompleteAt;
  dynamic transactionPhoto;
  String transactionNote;
  int customer;

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        orderId: json["order_id"],
        totalPrice: json["total_price"],
        note: json["note"],
        orderStatus: json["order_status"],
        rejectReason: json["reject_reason"],
        createdAt: DateTime.parse(json["created_at"]),
        orderCompleteAt: json["order_complete_at"],
        transactionPhoto: json["transaction_photo"],
        transactionNote: json["transaction_note"],
        customer: json["customer"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "total_price": totalPrice,
        "note": note,
        "order_status": orderStatus,
        "reject_reason": rejectReason,
        "created_at": createdAt.toIso8601String(),
        "order_complete_at": orderCompleteAt,
        "transaction_photo": transactionPhoto,
        "transaction_note": transactionNote,
        "customer": customer,
      };
}
