import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sipenak_app/routes.dart';
import 'package:sipenak_app/screens/onboard/onboard_screen.dart';
import 'package:sipenak_app/theme.dart';

import 'api/api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await API().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      title: 'Si Penak',
      theme: theme(),
      initialRoute: OnboardScreen.routeName,
      navigatorObservers: [BotToastNavigatorObserver()],
      routes: routes,
    );
  }
}
