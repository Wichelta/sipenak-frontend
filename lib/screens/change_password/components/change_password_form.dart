import 'package:flutter/material.dart';
import 'package:sipenak_app/components/custom_surfix_icon.dart';
import 'package:sipenak_app/components/default_button.dart';
import 'package:sipenak_app/helper/my_helper.dart';
import 'package:sipenak_app/models/auth/register_model.dart';
import 'package:sipenak_app/helper/keyboard.dart';
import 'package:sipenak_app/screens/profile/profile_screen.dart';
import 'package:sipenak_app/api/api.dart';
import 'package:dio/dio.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  bool loading = false;
  bool loadingScreen = false;
  RegisterModel dataUser;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordFieldController =
      TextEditingController();
  final TextEditingController confirmNewPasswordFieldController =
      TextEditingController();

  @override
  void initState() {
    showDataUser();
    super.initState();
  }

  @override
  void dispose() {
    newPasswordFieldController.dispose();
    confirmNewPasswordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (loadingScreen)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: kTextColor,
            ),
            heightFactor: 13.5,
          )
        : Form(
            key: _formKey,
            child: Column(
              children: [
                buildNewPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildConfirmNewPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                loading
                    ? CircularProgressIndicator(
                        backgroundColor: kPrimaryColor,
                        color: kTextColor,
                      )
                    : DefaultButton(
                        text: "Simpan",
                        press: () {
                          changePassword();
                        },
                      ),
              ],
            ),
          );
  }

  Widget buildConfirmNewPasswordFormField() {
    return TextFormField(
      controller: confirmNewPasswordFieldController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Konfirmasi Password Baru",
        labelText: "Konfirmasi Password Baru",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (confirmNewPasswordFieldController.text.isEmpty) {
          return kPassNullError;
        } else if (confirmNewPasswordFieldController.text !=
            newPasswordFieldController.text) {
          return kMatchPassError;
        } else if (confirmNewPasswordFieldController.text.length < 8) {
          return kShortPassError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildNewPasswordFormField() {
    return TextFormField(
      controller: newPasswordFieldController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password Baru",
        labelText: "Password Baru",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
      validator: (value) {
        if (newPasswordFieldController.text.isEmpty) {
          return kPassNullError;
        } else if (newPasswordFieldController.text.length < 8) {
          return kShortPassError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> showDataUser() async {
    setState(() {
      loadingScreen = true;
    });

    var result =
        await API.get(API.register + await MyHelper.getPref(kId) + "/", null);
    dataUser = RegisterModel.fromJson(result);
    print(result);
    setState(() {
      loadingScreen = false;
    });
  }

  Future<void> changePassword() async {
    if (_formKey.currentState.validate()) {
      KeyboardUtil.hideKeyboard(context);

      setState(() {
        loading = true;
      });

      var params = {
        "password": newPasswordFieldController.text,
      };

      var result = await API.patch(
          API.register + await MyHelper.getPref(kId) + "/", params);
      RegisterModel dataUser = RegisterModel.fromJson(result);
      if (dataUser.success == true) {
        MyHelper.toast("Berhasil mengubah password.");
        MyHelper.navPush(context, ProfileScreen());
      } else {
        MyHelper.toast("Gagal mengubah password.");
      }

      setState(() {
        loading = false;
      });
    }
  }
}
