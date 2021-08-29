import 'package:flutter/material.dart';

import 'components/body.dart';

class ChangePasswordScreen extends StatelessWidget {
  static String routeName = "/change_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Body(),
    );
  }
}
