import 'package:flutter/material.dart';
import 'package:sipenak_app/size_config.dart';

import 'change_password_form.dart';

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
                SizedBox(height: 20),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                ChangePasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
