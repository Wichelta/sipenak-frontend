import 'package:flutter/material.dart';

import 'components/body.dart';

class VerifKTPScreen extends StatelessWidget {
  static String routeName = "/verif_ktp";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verifikasi KTP',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Body(),
    );
  }
}
