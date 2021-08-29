import 'package:flutter/widgets.dart';
import 'package:sipenak_app/screens/cart/cart_screen.dart';
import 'package:sipenak_app/screens/orders_detail/orderdetail_screen.dart';
import 'package:sipenak_app/screens/user_profile/user_profile_screen.dart';
import 'package:sipenak_app/screens/details/details_screen.dart';

import 'package:sipenak_app/screens/home/home_screen.dart';

import 'package:sipenak_app/screens/verif_ktp/verif_ktp_screen.dart';
import 'package:sipenak_app/screens/profile/profile_screen.dart';
import 'package:sipenak_app/screens/sign_in/sign_in_screen.dart';
import 'package:sipenak_app/screens/onboard/onboard_screen.dart';

import 'package:sipenak_app/screens/sign_up/sign_up_screen.dart';
import 'package:sipenak_app/screens/change_password/change_password_screen.dart';
import 'package:sipenak_app/screens/orders/orders_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  OnboardScreen.routeName: (context) => OnboardScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  UserProfileScreen.routeName: (context) => UserProfileScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  VerifKTPScreen.routeName: (context) => VerifKTPScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  OrdersScreen.routeName: (context) => OrdersScreen(),
  OrderDetailScreen.routeName: (context) => OrderDetailScreen(),
};
