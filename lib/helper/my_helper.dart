import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class MyHelper {
  static void navPush(BuildContext context, Widget form) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => form));
  }

  static void navPushReplacement(BuildContext context, Widget form) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => form));
  }

  static void navPop(BuildContext context, {var value = ""}) {
    Navigator.pop(context, value);
  }

  static void navPopUntil(BuildContext context, int countPop) {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= countPop);
  }

  static toast(String message) {
    BotToast.showText(
      text: message,
      duration: Duration(seconds: 3),
      align: const Alignment(0, 0.0),
    ); //popup a text toast;
  }

  static Future<void> setPref(String key, var value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);

    print("---> : set pref $value");
  }

  // --- How to use Future get pref : ---
  // MyHelper.getPref(MyConstanta.token).then((result){
  //  print("pref : " + result);
  //  write code here...
  // });
  static Future<String> getPref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("---> : get pref");
    return prefs.getString(key);
  }

  static deleteAllPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    print("---> : delete all pref");
  }

  static removeAnPref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);

    print("---> : remove an pref");
  }

  static void setPrefBearerToken(String token) {
    setPref(kToken, "Bearer " + token); //set bearer to pref
  }
}
