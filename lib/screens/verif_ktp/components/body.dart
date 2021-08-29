import 'package:flutter/material.dart';
import 'package:sipenak_app/components/custom_surfix_icon.dart';
import 'package:sipenak_app/components/default_button.dart';
import 'package:dio/dio.dart';
import 'package:sipenak_app/api/api.dart';
import 'package:sipenak_app/screens/profile/profile_screen.dart';
import 'package:sipenak_app/helper/keyboard.dart';
import 'package:sipenak_app/helper/my_helper.dart';
import 'package:sipenak_app/models/profile/profile_model.dart';
import 'dart:io';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;
  bool loadingScreen = false;
  DataProfileModel dataProfile;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nikFieldController = TextEditingController();
  File imageFile;

  @override
  void dispose() {
    _nikFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    showProfile();
    super.initState();
  }

  _imgFromCamera() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _imgFromGallery() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

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
                          children: <Widget>[
                            dataProfile.data.verificationStatus ==
                                    "Belum Terverifikasi"
                                ? Text(
                                    "Kamu belum terverifikasi.\nVerifikasi KTP dibutuhkan agar kamu dapat melakukan pemesanan produk.\n Silahkan menunggu konfirmasi jika kamu sudah mengajukan verifikasi.",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
                                    "Selamat, pengajuan verifikasi KTP kamu sudah kami konfirmasi. Akun kamu sudah terverifikasi sekarang.",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                            SizedBox(height: getProportionateScreenHeight(20)),
                            dataProfile.data.verificationStatus ==
                                    "Belum Terverifikasi"
                                ? Container(
                                    child: GestureDetector(
                                      onTap: () {
                                        _showPicker(context);
                                      },
                                      child: Container(
                                        child: imageFile != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  imageFile,
                                                  height: 200,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : dataProfile.data.ktpPhoto != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      dataProfile.data.ktpPhoto,
                                                      height: 200,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    height: 200,
                                                    width: double.infinity,
                                                    child: Icon(
                                                      Icons
                                                          .add_photo_alternate_sharp,
                                                      size: 30,
                                                    ),
                                                  ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        dataProfile.data.ktpPhoto,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            dataProfile.data.verificationStatus ==
                                    "Belum Terverifikasi"
                                ? buildNIKFormField()
                                : buildNIKAlreadyVerifiedFormField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            loading
                                ? CircularProgressIndicator(
                                    backgroundColor: kPrimaryColor,
                                    color: kTextColor,
                                  )
                                : DefaultButton(
                                    text: "Verifikasi Sekarang",
                                    press: () {
                                      if (dataProfile.data.verificationStatus ==
                                          "Belum Terverifikasi") {
                                        verifKTP();
                                      } else {
                                        MyHelper.toast(
                                            "Aksi dilarang! Kamu sudah terverifikasi!");
                                      }
                                    },
                                  ),
                            SizedBox(height: SizeConfig.screenHeight * 0.02),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  TextFormField buildNIKFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _nikFieldController,
      validator: (value) {
        if (_nikFieldController.text.isEmpty) {
          return kNIKNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "NIK",
        hintText: "NIK",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/id-card.svg"),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  TextFormField buildNIKAlreadyVerifiedFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _nikFieldController,
      validator: (value) {
        if (_nikFieldController.text.isEmpty) {
          return kNIKNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "NIK",
        hintText: "NIK",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/id-card.svg"),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
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
        _nikFieldController.text = dataProfile.data.nikKtp;
      });
      // MyHelper.toast("Berhasil mendapatkan data profil");
    }
    setState(() {
      loadingScreen = false;
    });
  }

  Future<void> verifKTP() async {
    if (_formKey.currentState.validate()) {
      KeyboardUtil.hideKeyboard(context);

      setState(() {
        loading = true;
      });

      var params = {
        "nik_ktp": _nikFieldController.text,
        if (imageFile != null)
          'ktp_photo': await MultipartFile.fromFile(imageFile.path,
              filename: 'userktp.jpg'),
      };

      if (!params.containsKey('ktp_photo')) {
        MyHelper.toast("Harap sertakan foto KTP kamu");
        setState(() {
          loading = false;
        });
        return;
      }

      var result = await API.patch(
          API.dataProfile + await MyHelper.getPref(kId) + "/", params);
      DataProfileModel dataProfile = DataProfileModel.fromJson(result);

      if (dataProfile.success == true) {
        MyHelper.toast("Berhasil mengajukan permintaan verifikasi KTP");
        MyHelper.navPush(context, ProfileScreen());
      } else {
        MyHelper.toast(
            "Proses gagal. NIK yang kamu gunakan sudah pernah digunakan");
      }

      setState(() {
        loading = false;
      });
    }
  }
}
