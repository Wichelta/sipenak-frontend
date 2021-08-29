import 'package:flutter/material.dart';
import 'package:sipenak_app/components/default_button.dart';

import 'package:sipenak_app/constants.dart';
import 'package:sipenak_app/controller/cart_controller.dart';
import 'package:sipenak_app/helper/my_helper.dart';

import 'package:sipenak_app/models/home/product_model.dart';

import 'package:sipenak_app/size_config.dart';
import 'package:sipenak_app/components/rounded_icon_btn.dart';

import 'product_description.dart';

import 'product_images.dart';

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   final ProductModel product;
//   _BodyState({this.product});
//   int _qty = 0;

class Body extends StatefulWidget {
  final ProductModel product;

  const Body({Key key, @required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int qty = 0;
  int maxQty = 0;

  @override
  void initState() {
    maxQty = widget.product.stock;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              ProductImages(product: widget.product),
              ProductDescription(
                product: widget.product,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedIconBtn(
                    icon: Icons.remove,
                    showShadow: true,
                    press: () {
                      setState(() {
                        if (qty > 0) qty--;
                      });
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  Text(
                    qty.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  RoundedIconBtn(
                    icon: Icons.add,
                    showShadow: true,
                    press: () {
                      setState(() {
                        if (qty < maxQty) qty++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: kTextColor,
                  inactiveTrackColor: kTextColor,
                  thumbColor: kPrimaryColor,
                  trackHeight: 0.80,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                ),
                child: Slider(
                  value: qty.toDouble(),
                  min: 0,
                  max: maxQty.toDouble(),
                  onChanged: (double newValue) {
                    setState(() {
                      qty = newValue.round();
                    });
                  },
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                ),
                child: DefaultButton(
                  text: "Tambah ke Keranjang",
                  press: () async {
                    var params = Map<String, dynamic>();
                    params["id"] = widget.product.id;
                    params["nama"] = widget.product.productName;
                    params["stok"] = widget.product.stock;
                    params["jumlah"] = qty;
                    params["satuan"] = widget.product.unit;
                    params["harga"] = widget.product.price;
                    params["gambar"] = widget.product.productPhoto;
                    if (qty >= 1) {
                      CartController.addToCart(params, context);
                    } else {
                      MyHelper.toast(
                          "Kamu tidak bisa menambah produk ke keranjang dengan jumlah 0");
                    }
                  },
                ),
                // FloatingActionButton.extended(
                //   backgroundColor: kPrimaryColor,
                //   label: Text(
                //     "Tambah",
                //     style: TextStyle(
                //       fontSize: 16,
                //     ),
                //   ),
                //   icon: Icon(
                //     Icons.add_shopping_cart_sharp,
                //   ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        ),
      ],
    );
  }
}
