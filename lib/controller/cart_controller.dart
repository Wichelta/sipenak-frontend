import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sipenak_app/constants.dart';
import 'package:sipenak_app/helper/my_helper.dart';

class CartController {
  static List<dynamic> cartList = [];

  static void clearAllCartList() {
    MyHelper.removeAnPref(kCartList);
    cartList = [];
  }

  static Future<void> addToCart(var params, BuildContext context) async {
    // {
    //     "id" : "int"
    //     "nama": "String",
    //     "jumlah": "int",
    //     "stok": "int",
    //     "harga": "int",
    //     "gambar": "String",
    // },

    String tempCartList = await MyHelper.getPref(kCartList);
    if (tempCartList != null) {
      cartList = jsonDecode(tempCartList);
    }

    // Cari nama produk, jika ada, maka replace di cartList
    List<dynamic> findCart =
        cartList.where((element) => element["id"] == params["id"]).toList();
    if (findCart.length > 0) {
      //replace
      int index = 0;

      for (var i = 0; i < cartList.length; i++) {
        if (cartList[i]["id"] == findCart[0]["id"]) {
          index = i;
        }
      }

      int tempJumlah = cartList[index]["jumlah"] + params["jumlah"];

      // print(cartList[index]["jumlah"]);
      // print(params["jumlah"]);

      if (tempJumlah > params["stok"]) {
        MyHelper.toast(
            "Stok tidak cukup, produk ini sudah ada di keranjang kamu dengan jumlah ${cartList[index]["jumlah"]}");
      } else {
        cartList[index]["jumlah"] =
            cartList[index]["jumlah"] + params["jumlah"];

        MyHelper.toast("Berhasil menambah ke keranjang");
        MyHelper.setPref(kCartList, jsonEncode(cartList));
        MyHelper.navPop(context);
      }
    } else {
      // add row
      cartList.add(
        {
          "id": params["id"],
          "nama": params["nama"],
          "jumlah": params["jumlah"],
          "harga": params["harga"],
          "gambar": params["gambar"],
          "satuan": params["satuan"],
        },
      );

      MyHelper.toast("Berhasil menambah ke keranjang");
      MyHelper.setPref(kCartList, jsonEncode(cartList));
      MyHelper.navPop(context);
    }
  }

  static Future<List> getList() async {
    String tempCartList = await MyHelper.getPref(kCartList);
    if (tempCartList != null) {
      return jsonDecode(tempCartList);
    } else {
      return [];
    }
  }

  static Future<void> deleteItem(int index) async {
    String tempCartList = await MyHelper.getPref(kCartList);
    if (tempCartList != null) {
      List<dynamic> cartListx = jsonDecode(tempCartList);

      cartListx.removeAt(index);

      MyHelper.setPref(kCartList, jsonEncode(cartListx));
    }
  }

  static Future<int> getJumlah() async {
    String tempCartList = await MyHelper.getPref(kCartList);
    if (tempCartList != null) {
      List cartListx = jsonDecode(tempCartList);
      int jumlah = 0;

      cartListx.forEach((element) {
        jumlah += element["jumlah"];
      });

      return jumlah;
    } else {
      return 0;
    }
  }

  static Future<int> totalHarga() async {
    String tempCartList = await MyHelper.getPref(kCartList);
    if (tempCartList != null) {
      List cartListx = jsonDecode(tempCartList);
      int totalHarga = 0;

      cartListx.forEach((element) {
        totalHarga = totalHarga + (element["jumlah"] * element["harga"]);
      });

      return totalHarga;
    } else {
      return 0;
    }
  }
}
