import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sipenak_app/screens/cart/cart_screen.dart';
import 'package:sipenak_app/screens/home/home_screen.dart';
import 'package:sipenak_app/screens/orders/orders_screen.dart';
import 'package:sipenak_app/screens/profile/profile_screen.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = kTextColor;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -5),
            blurRadius: 15,
            color: Color(0xFFDADADA).withOpacity(0.70),
          ),
        ],
      ),
      child: Container(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // GestureDetector(
              //   child: Icon(
              //     Icons.home,
              //     size: 30,
              //     color: MenuState.home == selectedMenu
              //         ? kPrimaryColor
              //         : inActiveIconColor,
              //   ),
              //   onTap: () {
              //     if (selectedMenu != MenuState.home) {
              //       Navigator.of(context).pushAndRemoveUntil(
              //           MaterialPageRoute(builder: (context) => HomeScreen()),
              //           (Route<dynamic> route) => false);
              //     }
              //   },
              // ),
              // GestureDetector(
              //   child: Icon(
              //     Icons.shopping_cart,
              //     size: 28,
              //     color: MenuState.cart == selectedMenu
              //         ? kPrimaryColor
              //         : inActiveIconColor,
              //   ),
              //   onTap: () {
              //     if (selectedMenu != MenuState.cart) {
              //       Navigator.of(context).pushAndRemoveUntil(
              //           MaterialPageRoute(builder: (context) => CartScreen()),
              //           (Route<dynamic> route) => false);
              //     }
              //   },
              // ),
              // GestureDetector(
              //   child: Icon(
              //     Icons.receipt_long_rounded,
              //     size: 28,
              //     color: MenuState.orders == selectedMenu
              //         ? kPrimaryColor
              //         : inActiveIconColor,
              //   ),
              //   onTap: () {
              //     if (selectedMenu != MenuState.orders) {
              //       Navigator.of(context).pushAndRemoveUntil(
              //           MaterialPageRoute(builder: (context) => OrdersScreen()),
              //           (Route<dynamic> route) => false);
              //     }
              //   },
              // ),
              // GestureDetector(
              //   child: Icon(
              //     Icons.person_rounded,
              //     size: 30,
              //     color: MenuState.profile == selectedMenu
              //         ? kPrimaryColor
              //         : inActiveIconColor,
              //   ),
              //   onTap: () {
              //     if (selectedMenu != MenuState.profile) {
              //       Navigator.of(context).pushAndRemoveUntil(
              //           MaterialPageRoute(
              //               builder: (context) => ProfileScreen()),
              //           (Route<dynamic> route) => false);
              //     }
              //   },
              // ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                  height: 20,
                  width: 20,
                ),
                onPressed: () {
                  if (selectedMenu != MenuState.home) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false);
                  }
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/cart.svg",
                  color: MenuState.cart == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                  height: 24,
                  width: 24,
                ),
                onPressed: () {
                  if (selectedMenu != MenuState.cart) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => CartScreen()),
                        (Route<dynamic> route) => false);
                  }
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/order.svg",
                  color: MenuState.orders == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                  height: 25,
                  width: 25,
                ),
                onPressed: () {
                  if (selectedMenu != MenuState.orders) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => OrdersScreen()),
                        (Route<dynamic> route) => false);
                  }
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                  height: 20,
                  width: 20,
                ),
                onPressed: () {
                  if (selectedMenu != MenuState.profile) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                        (Route<dynamic> route) => false);
                  }
                },
              ),
            ],
          )),
    );
  }
}
