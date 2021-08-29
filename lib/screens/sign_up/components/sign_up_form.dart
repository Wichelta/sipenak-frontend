import 'package:flutter/material.dart';
import 'package:sipenak_app/api/api.dart';
import 'package:sipenak_app/components/custom_surfix_icon.dart';
import 'package:sipenak_app/components/default_button.dart';

import 'package:sipenak_app/helper/keyboard.dart';
import 'package:sipenak_app/helper/my_helper.dart';
import 'package:sipenak_app/models/auth/register_model.dart';
import 'package:sipenak_app/screens/sign_in/sign_in_screen.dart';

import '../../../components/default_button.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameFieldController =
      TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final TextEditingController _confirmPasswordFieldController =
      TextEditingController();

  @override
  void dispose() {
    _usernameFieldController.dispose();
    _passwordFieldController.dispose();
    _confirmPasswordFieldController.dispose();
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
          buildConfirmPasswordFormField(),
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
              //       "Daftar Sekarang",
              //       style: TextStyle(
              //         fontSize: 16,
              //       ),
              //     ),
              //     icon: Icon(Icons.how_to_reg),
              //     onPressed: () {
              //       register();
              //     },
              //   ),
              DefaultButton(
                  text: "Daftar Sekarang",
                  press: () {
                    register();
                  },
                ),
        ],
      ),
    );
  }

  Widget buildConfirmPasswordFormField() {
    return TextFormField(
      controller: _confirmPasswordFieldController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Konfirmasi Password",
        labelText: "Konfirmasi Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (_confirmPasswordFieldController.text.isEmpty) {
          return kPassNullError;
        } else if (_confirmPasswordFieldController.text !=
            _passwordFieldController.text) {
          return kMatchPassError;
        } else if (_confirmPasswordFieldController.text.length < 8) {
          return kShortPassError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildPasswordFormField() {
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

  Future<void> register() async {
    if (_formKey.currentState.validate()) {
      KeyboardUtil.hideKeyboard(context);

      setState(() {
        loading = true;
      });

      var params = {
        "username": _usernameFieldController.text,
        "password": _passwordFieldController.text,
        "confirm_password": _confirmPasswordFieldController.text
      };

      var result = await API.post(API.register, params);
      RegisterModel register = RegisterModel.fromJson(result);
      if (register.success == true) {
        MyHelper.toast("Berhasil membuat akun");
        MyHelper.navPushReplacement(context, SignInScreen());
      } else {
        MyHelper.toast("Username sudah pernah dibuat, coba username lain");
      }

      setState(() {
        loading = false;
      });
    }
  }
}
