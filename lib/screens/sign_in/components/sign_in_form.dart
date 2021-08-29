import 'package:flutter/material.dart';
import 'package:sipenak_app/api/api.dart';
import 'package:sipenak_app/components/custom_surfix_icon.dart';

import 'package:sipenak_app/helper/keyboard.dart';
import 'package:sipenak_app/helper/my_helper.dart';
import 'package:sipenak_app/models/auth/login_model.dart';
import 'package:sipenak_app/screens/home/home_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameFieldController =
      TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();

  @override
  void dispose() {
    _usernameFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUsernameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          loading
              ? CircularProgressIndicator(
                  backgroundColor: kPrimaryColor,
                  color: kTextColor,
                )
              :
              // FloatingActionButton.extended(
              //     backgroundColor: kPrimaryColor,
              //     label: Text(
              //       "Masuk",
              //       style: TextStyle(
              //         fontSize: 16,
              //       ),
              //     ),
              //     icon: Icon(
              //       Icons.login,
              //     ),
              //     onPressed: () {
              //       login();
              //     },
              //   ),

              DefaultButton(
                  text: "Masuk",
                  press: () {
                    login();
                  },
                ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordFieldController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (_passwordFieldController.text.isEmpty) {
          return kPassNullError;
        } else if (_passwordFieldController.text.length < 8) {
          return kShortPassError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      controller: _usernameFieldController,
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Username",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
      validator: (value) {
        if (_usernameFieldController.text.isEmpty) {
          return kUsernameNullError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> login() async {
    if (_formKey.currentState.validate()) {
      KeyboardUtil.hideKeyboard(context);

      setState(() {
        loading = true;
      });

      var params = {
        "username": _usernameFieldController.text,
        "password": _passwordFieldController.text,
      };

      var result = await API.post(API.login, params);
      LoginModel login = LoginModel.fromJson(result);
      if (login.success == true) {
        MyHelper.toast("Berhasil login");
        MyHelper.navPush(context, HomeScreen());

        MyHelper.setPrefBearerToken(login.token);
        MyHelper.setPref(kId, login.id.toString());
        await API().init();
      } else {
        MyHelper.toast("Username atau Password salah!");
      }
      setState(() {
        loading = false;
      });
    }
  }
}
