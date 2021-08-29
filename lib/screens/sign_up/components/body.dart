import 'package:flutter/material.dart';
import 'package:sipenak_app/components/have_account_text.dart';
import 'package:sipenak_app/constants.dart';
import 'package:sipenak_app/size_config.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.08), // 4%
                Text("Daftar Akun", style: headingStyle),
                Text(
                  "Silahkan masukkan username dan password kamu untuk dapat membuat akun",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                SignUpForm(),
                SizedBox(height: getProportionateScreenHeight(20)),
                HaveAccountText(),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
