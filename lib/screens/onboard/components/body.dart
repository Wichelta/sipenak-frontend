import 'package:flutter/material.dart';

import 'package:sipenak_app/screens/sign_up/sign_up_screen.dart';
import 'package:sipenak_app/size_config.dart';
import 'package:sipenak_app/components/have_account_text.dart';

import '../components/onboard_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      OnboardContent(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      DefaultButton(
                        text: "Daftar Akun",
                        press: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      HaveAccountText(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
