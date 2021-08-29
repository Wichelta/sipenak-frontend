import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sipenak_app/components/nothingtoshow_container.dart';
import 'package:sipenak_app/controller/cart_controller.dart';
import 'package:sipenak_app/models/cart/createproduct_model.dart';
import 'package:sipenak_app/models/profile/profile_model.dart';
import 'package:sipenak_app/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:sipenak_app/api/api.dart';

import 'package:sipenak_app/helper/my_helper.dart';
import 'package:sipenak_app/models/cart/createorder_model.dart';

import 'package:sipenak_app/components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<dynamic> cartList = [];
  bool loadingScreen = false;

  DataProfileModel dataProfile;
  int jumlah = 0;
  int totalHarga = 0;

  @override
  void initState() {
    dataCart();
    showProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (loadingScreen)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: kTextColor,
            ),
            heightFactor: 15,
          )
        : Column(
            children: [
              Expanded(
                child: cartList.isEmpty
                    ? Center(
                        child: NothingToShowContainer(
                          iconPath: "assets/icons/empty-cart.svg",
                          primaryMessage:
                              "Kamu tidak memiliki produk di keranjang pesanan kamu",
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 1),
                          child: Dismissible(
                            key: Key(cartList[index]["nama"]),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() async {
                                await cartList.removeAt(index);
                                await CartController.deleteItem(index);
                                await dataCart();
                              });
                            },
                            background: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFE6E6),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  SvgPicture.asset("assets/icons/Trash.svg"),
                                ],
                              ),
                            ),
                            child: CartCard(cart: cartList[index]),
                          ),
                        ),
                      ),
              ),
              CheckoutCard(
                cartCount: cartList.length,
                totalHarga: totalHarga,
                cartList: cartList,
              ),
            ],
          );
  }

  Future<void> showProfile() async {
    setState(() {
      loadingScreen = true;
    });

    var result = await API.get(
        API.dataProfile + await MyHelper.getPref(kId) + "/", null);
    dataProfile = DataProfileModel.fromJson(result);

    setState(() {
      loadingScreen = false;
    });
  }

  Future<void> dataCart() async {
    cartList = await CartController.getList();
    jumlah = await CartController.getJumlah();
    totalHarga = await CartController.totalHarga();
    setState(() {});
  }
}

//Cart Card
class CartCard extends StatelessWidget {
  final dynamic cart;
  const CartCard({
    Key key,
    @required this.cart,
    // @required this.product,
  }) : super(key: key);

  // final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 3,
      // child: InkWell(
      //   onTap: () => Navigator.pushNamed(
      //     context,
      //     DetailsScreen.routeName,
      //     arguments: ProductDetailsArguments(product: product),
      //   ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    cart["gambar"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  cart["nama"],
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "\Rp ${cart["harga"]}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: " x${cart["jumlah"]}" + " ${cart["satuan"]}",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Checkout Card
class CheckoutCard extends StatefulWidget {
  final List<dynamic> cartList;

  final int totalHarga;
  final int cartCount;

  const CheckoutCard({Key key, this.totalHarga, this.cartCount, this.cartList})
      : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  bool loading = false;
  bool loadingScreen = false;

  DataProfileModel dataProfile;

  TextEditingController _noteFieldController = TextEditingController();

  @override
  void initState() {
    showProfile();
    super.initState();
  }

  @override
  void dispose() {
    _noteFieldController.dispose();

    super.dispose();
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            actionsPadding: EdgeInsets.only(right: 18, bottom: 20),
            title: Row(children: [
              Icon(
                Icons.done_sharp,
                size: 30,
                color: kPrimaryColor,
              ),
              Text(
                ' Berhasil',
                style: TextStyle(color: kPrimaryColor),
              )
            ]),
            content: Text(
                "Pesanan kamu berhasil dibuat, silahkan menunggu untuk konfirmasi berikutnya."),
            actions: <Widget>[
              FlatButton(
                color: kPrimaryColor,
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  MyHelper.navPushReplacement(context, HomeScreen());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(text: "${widget.cartCount} produk"),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\Rp ${widget.totalHarga}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _noteFieldController,
              decoration: InputDecoration(hintText: "Catatan"),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            loading
                ? CircularProgressIndicator(
                    backgroundColor: kPrimaryColor,
                    color: kTextColor,
                  )
                : DefaultButton(
                    text: "Pesan Sekarang",
                    press: () {
                      if (widget.cartCount >= 1) {
                        if (dataProfile.data.verificationStatus ==
                            "Terverifikasi") {
                          createorderid();
                          // _showDialog();
                        } else {
                          MyHelper.toast(
                              "Harap verifikasi akun terlebih dahulu untuk dapat membuat pesanan");
                        }
                      } else {
                        MyHelper.toast(
                            "Kamu tidak bisa membuat pesanan kosong");
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> showProfile() async {
    setState(() {
      loadingScreen = true;
    });

    var result = await API.get(
        API.dataProfile + await MyHelper.getPref(kId) + "/", null);
    dataProfile = DataProfileModel.fromJson(result);

    setState(() {
      loadingScreen = false;
    });
  }

  Future<void> createorderid() async {
    setState(() {
      loading = true;
    });

    var params = {
      "customer": await MyHelper.getPref(kId),
      "note": _noteFieldController.text,
      "total_price": widget.totalHarga
    };

    var result = await API.post(API.dataOrderId, params);
    CreateOrderIdModel createOrderId = CreateOrderIdModel.fromJson(result);
    if (createOrderId.orderStatus == "Belum Dikonfirmasi") {
      String orderId = createOrderId.orderId;

      widget.cartList.forEach((elementCart) async {
        var params = {
          "quantity": elementCart["jumlah"],
          "product": elementCart["id"],
          "order_id": orderId
        };

        // print(params);
        await createOrderProduct(params);
      });

      CartController.clearAllCartList();
      _showDialog();
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> createOrderProduct(var params) async {
    var result = await API.post(API.dataOrderProduct, params);
    var resultData = OrderProductModel.fromJson(result);

    if (resultData.id != null) {
      // no action
    } else {
      MyHelper.toast("Gagal");
    }
  }
}
