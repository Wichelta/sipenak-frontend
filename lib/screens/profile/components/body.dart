import 'package:sipenak_app/api/api.dart';

import 'package:sipenak_app/helper/my_helper.dart';
import 'package:sipenak_app/models/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:sipenak_app/constants.dart';

import 'package:sipenak_app/screens/sign_in/sign_in_screen.dart';
import 'package:sipenak_app/screens/user_profile/user_profile_screen.dart';
import 'package:sipenak_app/screens/verif_ktp/verif_ktp_screen.dart';
import 'package:sipenak_app/screens/change_password/change_password_screen.dart';
import 'profile_menu.dart';

class Body extends StatefulWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool loading = false;
  DataProfileModel dataProfile;

  @override
  void initState() {
    showProfile();
    super.initState();
  }

  void _showDialogAbout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 35, top: 10, right: 35),
          actionsPadding: EdgeInsets.only(top: 5, right: 20, bottom: 25),
          title: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.info_outline_rounded,
                    size: 25,
                    color: kPrimaryColor,
                  ),
                ),
                TextSpan(
                  text: ' Si Penak',
                  style: TextStyle(color: kPrimaryColor, fontSize: 25),
                ),
              ],
            ),
          ),
          content: Text("versi: 1.0.0"),
          actions: <Widget>[
            FlatButton(
              color: kPrimaryColor,
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 35, top: 10, right: 35),
          actionsPadding: EdgeInsets.only(top: 5, right: 40, bottom: 25),
          title: Row(children: [
            Icon(
              Icons.notifications_none,
              size: 30,
              color: Colors.red,
            ),
            Text(
              ' Logout',
              style: TextStyle(color: Colors.red),
            )
          ]),
          content: Text("Apakah anda yakin ingin logout?"),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              child: Text(
                "BATAL",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: kPrimaryColor,
              child: Text(
                "YA",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // Navigator.of(context).pop();
                MyHelper.removeAnPref(kToken);
                MyHelper.toast("Berhasil logout");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (Route<dynamic> route) => false);
                // MyHelper.navPushReplacement(context, SignInScreen());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: kTextColor,
            ),
            heightFactor: 15,
          )
        : SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 10),
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                      ),
                      dataProfile.data.profilePhoto != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
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
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    child: dataProfile.data.fullName == ""
                        ? Text(
                            "Pengguna Baru",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        : Text(
                            dataProfile.data.fullName,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )),
                dataProfile.data.verificationStatus == "Belum Terverifikasi"
                    ? Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(dataProfile.data.verificationStatus,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      )
                    : Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(dataProfile.data.verificationStatus,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                SizedBox(height: 15),
                ProfileMenu(
                  text: "Profil",
                  icon: "assets/icons/User Icon.svg",
                  press: () => {
                    Navigator.pushNamed(context, UserProfileScreen.routeName)
                  },
                ),
                ProfileMenu(
                  text: "Verifikasi KTP",
                  icon: "assets/icons/id-card.svg",
                  press: () => {
                    if (dataProfile.data.fullName != "" &&
                        dataProfile.data.email != "" &&
                        dataProfile.data.phoneNumber != "" &&
                        dataProfile.data.address != "")
                      {
                        Navigator.pushNamed(context, VerifKTPScreen.routeName),
                      }
                    else
                      {
                        MyHelper.toast(
                            "Lengkapi profil terlebih dahulu untuk dapat mengakses halaman verifikasi KTP")
                      }
                  },
                ),
                ProfileMenu(
                  text: "Ubah Password",
                  icon: "assets/icons/Settings.svg",
                  press: () => {
                    Navigator.pushNamed(context, ChangePasswordScreen.routeName)
                  },
                ),
                ProfileMenu(
                  text: "Tentang",
                  icon: "assets/icons/information.svg",
                  press: () {
                    _showDialogAbout();
                  },
                ),
                ProfileMenu(
                  text: "Logout",
                  icon: "assets/icons/Log out.svg",
                  press: () {
                    _showDialog();
                    // MyHelper.removeAnPref(kToken);
                    // MyHelper.toast("Logout");
                    // MyHelper.navPushReplacement(context, SignInScreen());
                  },
                ),
              ],
            ),
          );
  }

  Future<void> showProfile() async {
    setState(() {
      loading = true;
    });

    var result = await API.get(
        API.dataProfile + await MyHelper.getPref(kId) + "/", null);
    dataProfile = DataProfileModel.fromJson(result);

    setState(() {
      loading = false;
    });
  }
}
