import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sipenak_app/components/custom_bottom_nav_bar.dart';
import 'package:sipenak_app/enums.dart';

import 'components/body.dart';

DateTime currentBackPressTime;

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(child: Body(), onWillPop: onWillPop),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      BotToast.showText(
        text: "Ketuk lagi untuk keluar",
        duration: Duration(seconds: 2),
        align: const Alignment(0, 0.0),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
