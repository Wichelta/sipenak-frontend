import 'package:flutter/material.dart';

import 'components/body.dart';

class UserProfileScreen extends StatelessWidget {
  static String routeName = "/user_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah Profil',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Body(),
    );
  }
}
