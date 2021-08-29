import 'package:flutter/material.dart';
import 'package:sipenak_app/models/home/product_model.dart';

import '../../../size_config.dart';
import 'expandable_text.dart';
import 'dart:ui';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: product.productName,
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Stok : ' + product.stock.toString() + ' ' + product.unit,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                'Harga : Rp ' + product.price.toString() + '/' + product.unit,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                'Lokasi : ' + product.location,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 16),
              ExpandableText(
                title: "Deskripsi : ",
                content: product.description,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
