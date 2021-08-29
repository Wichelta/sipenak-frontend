import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sipenak_app/api/api.dart';
import 'package:sipenak_app/components/custom_surfix_icon.dart';
import 'package:sipenak_app/components/default_button.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sipenak_app/screens/profile/profile_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:sipenak_app/helper/keyboard.dart';
import 'package:sipenak_app/helper/my_helper.dart';
import 'package:sipenak_app/models/profile/profile_model.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;
  bool loadingScreen = false;

  final _formKey = GlobalKey<FormState>();

  DataProfileModel dataProfile;

  TextEditingController _fullnameFieldController = TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _phonenumberFieldController =
      TextEditingController();
  final TextEditingController _addressFieldController = TextEditingController();

  File imageFile;

  _imgFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _imgFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxHeight: 800,
        maxWidth: 800);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library_sharp),
                    title: new Text('Galeri'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera_sharp),
                  title: new Text('Kamera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    showProfile();
    super.initState();
  }

  @override
  void dispose() {
    _fullnameFieldController.dispose();
    _emailFieldController.dispose();
    _phonenumberFieldController.dispose();
    _addressFieldController.dispose();
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
            heightFactor: 15.5,
          )
        : SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      SizedBox(height: SizeConfig.screenHeight * 0.03),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 115,
                              width: 115,
                              child: Stack(
                                fit: StackFit.expand,
                                overflow: Overflow.visible,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  imageFile != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          child: Image.file(
                                            imageFile,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : dataProfile.data.profilePhoto != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(1000),
                                              child: Image.network(
                                                dataProfile.data.profilePhoto,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Container(
                                              child: Icon(
                                                Icons.person_sharp,
                                                size: 40,
                                                color: kTextColor,
                                              ),
                                            ),
                                  Positioned(
                                    right: -5,
                                    bottom: 0,
                                    child: SizedBox(
                                      height: 46,
                                      width: 46,
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                          side: BorderSide(color: Colors.white),
                                        ),
                                        color: Color(0xFFF5F6F9),
                                        onPressed: () {
                                          _showPicker(context);
                                        },
                                        child: SvgPicture.asset(
                                            "assets/icons/Camera Icon.svg"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            buildFullNameFormField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            buildEmailFormField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            buildPhoneNumberFormField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            buildAddressFormField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            loading
                                ? CircularProgressIndicator(
                                    backgroundColor: kPrimaryColor,
                                    color: kTextColor,
                                  )
                                : DefaultButton(
                                    text: "Simpan",
                                    press: () {
                                      changeProfileData();
                                    },
                                  ),
                            SizedBox(height: SizeConfig.screenHeight * 0.02),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: _addressFieldController,
      decoration: InputDecoration(
        labelText: "Alamat",
        hintText: "Alamat",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
      validator: (value) {
        if (_addressFieldController.text.isEmpty) {
          return kAddressNullError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _phonenumberFieldController,
      decoration: InputDecoration(
        labelText: "Nomer Telepon",
        hintText: "Nomer Telepon",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
      validator: (value) {
        if (_phonenumberFieldController.text.isEmpty) {
          return kPhoneNumberNullError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailFieldController,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
      validator: (value) {
        if (_emailFieldController.text.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(_emailFieldController.text)) {
          return kInvalidEmailError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      controller: _fullnameFieldController,
      decoration: InputDecoration(
        labelText: "Nama Lengkap",
        hintText: "Nama Lengkap",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
      validator: (value) {
        if (_fullnameFieldController.text.isEmpty) {
          return kFullNameNullError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> showProfile() async {
    setState(() {
      loadingScreen = true;
    });

    var result = await API.get(
        API.dataProfile + await MyHelper.getPref(kId) + "/", null);
    dataProfile = DataProfileModel.fromJson(result);

    if (dataProfile.success == true) {
      setState(() {
        _fullnameFieldController.text = dataProfile.data.fullName;
        _emailFieldController.text = dataProfile.data.email;
        _phonenumberFieldController.text = dataProfile.data.phoneNumber;
        _addressFieldController.text = dataProfile.data.address;
      });
      // MyHelper.toast("Berhasil mendapatkan data profil");
    }
    setState(() {
      loadingScreen = false;
    });
  }

  Future<void> changeProfileData() async {
    if (_formKey.currentState.validate()) {
      KeyboardUtil.hideKeyboard(context);

      setState(() {
        loading = true;
      });

      var params = {
        "full_name": _fullnameFieldController.text,
        "email": _emailFieldController.text,
        "phone_number": _phonenumberFieldController.text,
        "address": _addressFieldController.text,
        if (imageFile != null)
          'profile_photo': await MultipartFile.fromFile(imageFile.path,
              filename: 'userprofile.jpg'),
      };

      var result = await API.patch(
          API.dataProfile + await MyHelper.getPref(kId) + "/", params);
      DataProfileModel dataProfile = DataProfileModel.fromJson(result);
      if (dataProfile.success == true) {
        MyHelper.toast("Berhasil menyimpan data profil");
        MyHelper.navPush(context, ProfileScreen());
      } else {
        MyHelper.toast("Gagal menyimpan data profil");
      }

      setState(() {
        loading = false;
      });
    }
  }
}
