import 'package:flutter/material.dart';
import 'package:sipenak_app/constants.dart';
import 'package:sipenak_app/helper/my_helper.dart';

import 'package:sipenak_app/models/orders_history/orderdetail_model.dart';
import 'package:sipenak_app/models/orders_history/orderhistory_model.dart';
import 'package:sipenak_app/api/api.dart';
import 'package:flutter/services.dart';

import '../../../size_config.dart';
import 'package:intl/intl.dart';

class OrderDescription extends StatefulWidget {
  const OrderDescription({
    Key key,
    @required this.orderHistory,
  }) : super(key: key);

  final OrderHistoryModel orderHistory;

  @override
  State<OrderDescription> createState() => _OrderDescriptionState();
}

class _OrderDescriptionState extends State<OrderDescription> {
  bool loading = false;

  List<OrderDetailModel> dataOrderProduct = [];

  @override
  void initState() {
    getDetailProduk();

    super.initState();
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.orderHistory.orderId));
    MyHelper.toast("Berhasil menyalin nomor pesanan");
  }

  @override
  Widget build(BuildContext context) {
    var tempDateCreated =
        DateTime.parse(widget.orderHistory.createdAt.toString());
    final convertLocal = tempDateCreated.toLocal();
    var newFormat = DateFormat("kk:mm, yy-MM-dd");

    String dateCreated = newFormat.format(convertLocal);

    return (loading)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: kTextColor,
            ),
            heightFactor: 15,
          )
        : Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.orderHistory.orderStatus == "Belum Dikonfirmasi"
                    ? GestureDetector(
                        onTap: _copyToClipboard,
                        child: Stack(
                          overflow: Overflow.visible,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: kTextColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "Nomor Pesanan : ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: widget.orderHistory.orderId,
                                      style: TextStyle(
                                        fontSize: 25,
                                        // fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(20)),
                                  Text.rich(
                                    TextSpan(
                                      text: widget.orderHistory.orderStatus,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 30,
                              bottom: 30,
                              child: SizedBox(
                                height: 110,
                                width: 110,
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              bottom: 20,
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 80,
                              top: 30,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(1000),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : widget.orderHistory.orderStatus == "Diterima"
                        ? GestureDetector(
                            onTap: _copyToClipboard,
                            child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: "Nomor Pesanan : ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            // fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: _copyToClipboard,
                                        child: Text.rich(
                                          TextSpan(
                                            text: widget.orderHistory.orderId,
                                            style: TextStyle(
                                              fontSize: 25,
                                              // fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(20)),
                                      Text.rich(
                                        TextSpan(
                                          text: widget.orderHistory.orderStatus,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            // fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 30,
                                  bottom: 30,
                                  child: SizedBox(
                                    height: 110,
                                    width: 110,
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  bottom: 20,
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 80,
                                  top: 30,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : widget.orderHistory.orderStatus ==
                                "Sudah Bisa Diambil"
                            ? GestureDetector(
                                onTap: _copyToClipboard,
                                child: Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text: "Nomor Pesanan : ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                // fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: _copyToClipboard,
                                            child: Text.rich(
                                              TextSpan(
                                                text:
                                                    widget.orderHistory.orderId,
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  // fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      20)),
                                          Text.rich(
                                            TextSpan(
                                              text: widget
                                                  .orderHistory.orderStatus,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                // fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 30,
                                      bottom: 30,
                                      child: SizedBox(
                                        height: 110,
                                        width: 110,
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 20,
                                      bottom: 20,
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 80,
                                      top: 30,
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : widget.orderHistory.orderStatus == "Selesai"
                                ? GestureDetector(
                                    onTap: _copyToClipboard,
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  text: "Nomor Pesanan : ",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    // fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: _copyToClipboard,
                                                child: Text.rich(
                                                  TextSpan(
                                                    text: widget
                                                        .orderHistory.orderId,
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      // fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          20)),
                                              Text.rich(
                                                TextSpan(
                                                  text: widget
                                                      .orderHistory.orderStatus,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    // fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 30,
                                          bottom: 30,
                                          child: SizedBox(
                                            height: 110,
                                            width: 110,
                                            child: Container(
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 20,
                                          bottom: 20,
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Container(
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 80,
                                          top: 30,
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Container(
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: _copyToClipboard,
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  text: "Nomor Pesanan : ",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    // fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: _copyToClipboard,
                                                child: Text.rich(
                                                  TextSpan(
                                                    text: widget
                                                        .orderHistory.orderId,
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      // fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          20)),
                                              Text.rich(
                                                TextSpan(
                                                  text: widget
                                                      .orderHistory.orderStatus,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    // fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 30,
                                          bottom: 30,
                                          child: SizedBox(
                                            height: 110,
                                            width: 110,
                                            child: Container(
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 20,
                                          bottom: 20,
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Container(
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 80,
                                          top: 30,
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Container(
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                SizedBox(height: getProportionateScreenHeight(20)),
                widget.orderHistory.orderStatus == "Selesai" &&
                        widget.orderHistory.transactionPhoto != null
                    ? Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.orderHistory.transactionPhoto,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(),
                widget.orderHistory.orderStatus == "Selesai" &&
                        widget.orderHistory.transactionPhoto != null
                    ? SizedBox(height: getProportionateScreenHeight(20))
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(15),
                    right: getProportionateScreenWidth(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Catatan : \n" +
                              (widget.orderHistory.note == ""
                                  ? "-"
                                  : widget.orderHistory.note),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Text.rich(
                        TextSpan(
                          text: "Waktu pesanan dibuat : \n" + dateCreated,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      widget.orderHistory.orderStatus == "Ditolak"
                          ? Text.rich(
                              TextSpan(
                                text: "Alasan ditolak : \n" +
                                    (widget.orderHistory.rejectReason == ""
                                        ? "-"
                                        : widget.orderHistory.rejectReason),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Container(),
                      widget.orderHistory.orderStatus == "Ditolak"
                          ? SizedBox(height: getProportionateScreenHeight(20))
                          : Container(),
                      widget.orderHistory.orderStatus == "Selesai"
                          ? Text.rich(
                              TextSpan(
                                text: "Waktu pesanan selesai : \n" +
                                    (widget.orderHistory.orderCompleteAt == null
                                        ? '-'
                                        : "${widget.orderHistory.orderCompleteAt}"),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Container(),
                      widget.orderHistory.orderStatus == "Selesai"
                          ? SizedBox(height: getProportionateScreenHeight(20))
                          : Container(),
                      widget.orderHistory.orderStatus == "Selesai"
                          ? Text.rich(
                              TextSpan(
                                text: "Catatan tambahan saat transaksi : \n" +
                                    (widget.orderHistory.transactionNote == ''
                                        ? '-'
                                        : "${widget.orderHistory.transactionNote}"),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Container(),
                      widget.orderHistory.orderStatus == "Selesai"
                          ? SizedBox(height: getProportionateScreenHeight(20))
                          : Container(),
                      Text.rich(
                        TextSpan(
                            text: "Rincian produk :",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 18,
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(15),
                    right: getProportionateScreenWidth(15),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        ...List.generate(
                          dataOrderProduct.length,
                          (index) {
                            return OrderDetailProductName(
                                orderDetail: dataOrderProduct[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(15),
                    right: getProportionateScreenWidth(15),
                  ),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(15),
                    right: getProportionateScreenWidth(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Total Harga : Rp " +
                            widget.orderHistory.totalPrice.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> getDetailProduk() async {
    setState(() {
      loading = true;
    });

    String tempOrderId = widget.orderHistory.orderId;

    var params = Map<String, dynamic>();

    var result = await API.get(API.dataOrderProduct, params);

    List<dynamic> tempdataOrderProduct = List<OrderDetailModel>.from(
        result.map((x) => OrderDetailModel.fromJson(x)));

    dataOrderProduct = tempdataOrderProduct
        .where(
            (element) => element.orderId.toString() == tempOrderId.toString())
        .toList();

    setState(() {
      loading = false;
    });
  }
}

class OrderDetailProductName extends StatelessWidget {
  const OrderDetailProductName({
    Key key,
    @required this.orderDetail,
  }) : super(key: key);

  final OrderDetailModel orderDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                orderDetail.productName,
                style: TextStyle(color: Colors.black, fontSize: 15),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Rp " + orderDetail.price.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: [
                        TextSpan(
                          text: " x" +
                              orderDetail.quantity.toString() +
                              ' ' +
                              orderDetail.unit,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Rp " + orderDetail.totalProductPrice.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
