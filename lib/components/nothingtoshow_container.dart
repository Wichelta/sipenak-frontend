import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NothingToShowContainer extends StatelessWidget {
  final String iconPath;
  final String primaryMessage;

  const NothingToShowContainer({
    Key key,
    this.iconPath = "",
    this.primaryMessage = "",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              width: getProportionateScreenWidth(150),
            ),
            SizedBox(height: 16),
            Text(
              "$primaryMessage",
              textAlign: TextAlign.center,
              style: TextStyle(color: kTextColor, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
