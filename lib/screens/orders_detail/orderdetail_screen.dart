import 'package:flutter/material.dart';

import 'package:sipenak_app/models/orders_history/orderhistory_model.dart';

import 'components/body.dart';

class OrderDetailScreen extends StatefulWidget {
  static String routeName = "/orderdetails";

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final OrderHistoryArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Informasi Pesanan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Body(orderHistory: agrs.orderHistory),
    );
  }
}

class OrderHistoryArguments {
  final OrderHistoryModel orderHistory;

  OrderHistoryArguments({@required this.orderHistory});
}
