import 'package:sipenak_app/helper/my_helper.dart';

import '../constants.dart';
import 'package:dio/dio.dart';

var dio = Dio();

class API {
  static String login = SERVER_IP + "akun_pengguna/login";
  static String register = SERVER_IP + "akun_pengguna/user/";
  static String dataProduct = SERVER_IP + "data_komoditas/product/";
  static String dataOrderId = SERVER_IP + "data_pesanan/semua_pesanan/";
  static String dataOrderProduct =
      SERVER_IP + "data_pesanan/detail_semua_pesanan/";
  static String dataProfile = SERVER_IP + "akun_pengguna/user/profile/";
  static String token;

  Future<void> init() async {
    dio = Dio(BaseOptions(
        // baseUrl: MyConstanta.urlAPI,
        connectTimeout: 45000,
        receiveTimeout: 45000,
        contentType: "application/json",
        responseType: ResponseType.json));

    setDioHeader();
    await setTokenHeader();
  }

  void setDioHeader() {
    dio.options.headers = {'accept': 'application/json'};
  }

  setTokenHeader() async {
    token = await MyHelper.getPref(kToken);
    if (token != null) {
      dio.options.headers.putIfAbsent("Authorization", () => token);
    }
  }

  static Future<dynamic> get(String url, var params) async {
    try {
      print("--> : start request");

      Response response = await dio.get(
        url,
        queryParameters: params,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        MyHelper.toast("Terjadi Kesalahan");
        print(response.data.toString());
        return null;
      }
    } catch (e) {
      // MyHelper.toast(e.toString());
      MyHelper.toast("Terjadi Kesalahan");
      print(e.toString());
      return null;
    }
  }

  static Future<dynamic> post(String url, var params) async {
    try {
      print("--> : start request");

      Response response = await dio.post(url, data: params //for post method
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        MyHelper.toast("Terjadi Kesalahan");
        print(response.data.toString());
        return null;
      }
    } catch (e) {
      // MyHelper.toast(e.toString());
      MyHelper.toast("Terjadi Kesalahan");
      print(e.toString());
      return null;
    }
  }

  static Future<dynamic> patch(String url, var params) async {
    try {
      print("--> : start request");

      FormData formData = FormData.fromMap(params);

      Response response = await dio.patch(url, data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        MyHelper.toast("Terjadi Kesalahan");
        print(response.data.toString());
        return null;
      }
    } catch (e) {
      MyHelper.toast("Terjadi Kesalahan");
      // MyHelper.toast(e.toString());
      print(e.toString());
      return null;
    }
  }

  static Future<dynamic> postMiltipart(String url, var params) async {
    try {
      print("--> : start request");

      FormData formData = FormData.fromMap(params);

      Response response = await dio.post(
        url,
        data: formData, //for post method
        onSendProgress: (int sent, int total) {
          print("Mengupload... [" +
              double.parse(((sent / total) * 100).toStringAsFixed(2))
                  .toString() +
              "%]");
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        MyHelper.toast("Terjadi Kesalahan");
        print(response.data.toString());
        return null;
      }
    } catch (e) {
      // MyHelper.toast(e.toString());
      MyHelper.toast("Terjadi Kesalahan");
      print(e.toString());
      return null;
    }
  }
}
