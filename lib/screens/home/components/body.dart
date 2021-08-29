import 'package:flutter/material.dart';

import 'all_product.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AllProducts(),
    );
  }
}
