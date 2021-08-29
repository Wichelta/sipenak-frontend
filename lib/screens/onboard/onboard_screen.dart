import 'package:flutter/material.dart';
import 'package:sipenak_app/constants.dart';
import 'package:sipenak_app/helper/my_helper.dart';
import 'package:sipenak_app/screens/home/home_screen.dart';
import 'package:sipenak_app/screens/onboard/components/body.dart';
import 'package:sipenak_app/size_config.dart';

class OnboardScreen extends StatefulWidget {
  static String routeName = "/onboard";

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {

  @override
  void initState() {
    skipOnboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }

  void skipOnboard() {
    MyHelper.getPref(kToken).then((value) {
      if (value != null) {
        MyHelper.navPushReplacement(context, HomeScreen());
      }
    });
  }
}
