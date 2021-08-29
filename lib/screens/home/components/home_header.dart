import 'package:flutter/material.dart';
import 'package:sipenak_app/helper/my_helper.dart';
import 'package:sipenak_app/screens/cart/cart_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text("SI PENAK", style: headingStyle),
          ),
          IconBtnWithCounter(
              svgSrc: "assets/icons/whatsapp.svg",
              press: () {
                launchWhatsApp();
              }),

          // FloatingActionButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, CartScreen.routeName);
          //   },
          //   child: const Icon(
          //     Icons.shopping_cart,
          //     color: kTextColor,
          //   ),
          //   backgroundColor: Colors.white,
          //   tooltip: "Keranjang Belanja",
          // ),
        ],
      ),
    );
  }

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+628991049322',
      text: "Halo, saya ingin menanyakan mengenai",
    );
    await launch('$link');
  }
}
