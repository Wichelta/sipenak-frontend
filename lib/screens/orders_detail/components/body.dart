import 'package:flutter/material.dart';
import 'package:sipenak_app/components/default_button.dart';

import 'package:sipenak_app/constants.dart';
import 'package:sipenak_app/controller/cart_controller.dart';
import 'package:sipenak_app/helper/my_helper.dart';

import 'package:sipenak_app/models/home/product_model.dart';
import 'package:sipenak_app/models/orders_history/orderdetail_model.dart';
import 'package:sipenak_app/models/orders_history/orderhistory_model.dart';

import 'package:sipenak_app/size_config.dart';
import 'package:sipenak_app/components/rounded_icon_btn.dart';
import 'package:sipenak_app/api/api.dart';

import 'order_description.dart';

class Body extends StatefulWidget {
  final OrderHistoryModel orderHistory;

  const Body({Key key, @required this.orderHistory}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              OrderDescription(
                orderHistory: widget.orderHistory,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              SizedBox(height: getProportionateScreenHeight(20)),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        ),
      ],
    );
  }
}
