import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.10),
              Text(
                "Si Penak",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(25),
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Selamat datang di Si Penak!\nSi Penak adalah Aplikasi Penjualan Komoditas Ternak milik Dinas Perkebunan dan Peternakan\nProvinsi Kalimantan Barat.\n",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              Image.asset(
                "assets/images/Welcome.gif",
                height: getProportionateScreenHeight(270),
                width: getProportionateScreenWidth(235),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
