import 'package:flutter/material.dart';
import 'package:sipenak_app/size_config.dart';

const SERVER_IP = 'https://sipenak-server.herokuapp.com/api/';
const kToken = "bearerToken";
const kId = "id";
const kCartList = "kCartList";

const kPrimaryColor = Color(0xFF11C4A8);
const kSecondaryColor = Color(0xFF292D33);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Harap masukkan email!";
const String kInvalidEmailError = "Harap masukkan email yang valid!";
const String kUsernameNullError = "Harap masukkan username!";
const String kPassNullError = "Harap masukkan password!";
const String kShortPassError = "Password terlalu pendek!\nMinimal 8 karakter.";
const String kMatchPassError = "Kedua password tidak cocok!";
const String kFullNameNullError = "Harap masukkan nama lengkap!";
const String kNIKNullError = "Harap masukkan NIK!";
const String kPhoneNumberNullError = "Harap masukkan nomer telepon!";
const String kAddressNullError = "Harap masukkan alamat!";

// final otpInputDecoration = InputDecoration(
//   contentPadding:
//       EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
//   border: outlineInputBorder(),
//   focusedBorder: outlineInputBorder(),
//   enabledBorder: outlineInputBorder(),
// );

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
    borderSide: BorderSide(color: kTextColor),
  );
}

const kDefaultPaddin = 20.0;
