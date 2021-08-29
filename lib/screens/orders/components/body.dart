import 'package:sipenak_app/helper/my_helper.dart';
import 'package:sipenak_app/models/orders_history/orderhistory_model.dart';
import 'package:sipenak_app/screens/orders_detail/orderdetail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../size_config.dart';
import 'package:sipenak_app/components/nothingtoshow_container.dart';

import 'package:flutter/material.dart';
import 'package:sipenak_app/api/api.dart';

import '../../../constants.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 5);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Riwayat Pesanan",
          style: TextStyle(color: Colors.black),
        ),
        bottom: new TabBar(
          isScrollable: true,
          indicatorColor: kPrimaryColor,
          labelColor: Colors.black,
          unselectedLabelColor: kTextColor,
          controller: controller,
          tabs: <Widget>[
            new Tab(text: "Belum Dikonfirmasi"),
            new Tab(text: "Diterima"),
            new Tab(text: "Sudah Bisa Diambil"),
            new Tab(text: "Selesai"),
            new Tab(text: "Ditolak"),
          ],
        ),
      ),
      body: new TabBarView(
        //controller untuk tab bar
        controller: controller,
        children: <Widget>[
          new UnconfirmedOrder(),
          new AcceptedOrder(),
          new ReadyToPickupOrder(),
          new FinishedOrder(),
          new RejectedOrder(),
        ],
      ),
    );
  }
}

//Tab bar pesanan belum dikonfirmasi
class UnconfirmedOrder extends StatefulWidget {
  @override
  State<UnconfirmedOrder> createState() => _UnconfirmedOrderState();
}

class _UnconfirmedOrderState extends State<UnconfirmedOrder> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String cusId;
  bool loading = false;

  List<OrderHistoryModel> orderHistory = [];

  @override
  void initState() {
    dataHistoryOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: kTextColor,
            ),
            // heightFactor: 15.5,
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
              ),
              (orderHistory
                          .where(
                              (element) => element.customer.toString() == cusId)
                          .toList()
                          .length ==
                      0)
                  ? Center(
                      heightFactor: 2.2,
                      child: NothingToShowContainer(
                        iconPath: "assets/icons/empty-order.svg",
                        primaryMessage: "Kamu tidak memiliki riwayat pesanan",
                      ),
                    )
                  : Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        controller: _refreshController,
                        onRefresh: () => dataHistoryOrders(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              ...List.generate(
                                orderHistory.length,
                                (index) {
                                  if (orderHistory[index].customer.toString() ==
                                      cusId) {
                                    return OrderHistoryCard(
                                        orderHistory: orderHistory[index]);
                                  }
                                  return Container();
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(20)),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
  }

  Future<void> dataHistoryOrders() async {
    setState(() {
      loading = true;
    });

    cusId = await MyHelper.getPref(kId);

    var params = Map<String, dynamic>();

    var result = await API.get(API.dataOrderId, params);

    List<dynamic> tempOrderHistory = List<OrderHistoryModel>.from(
        result.map((x) => OrderHistoryModel.fromJson(x)));

    orderHistory = tempOrderHistory
        .where((element) => element.orderStatus == "Belum Dikonfirmasi")
        .toList();

    // orderHistory = List<OrderHistoryModel>.from(
    //     result.map((x) => OrderHistoryModel.fromJson(x)));
    print(result);
    setState(() {
      loading = false;
    });
  }
}

//Tab bar pesanan diterima
class AcceptedOrder extends StatefulWidget {
  @override
  State<AcceptedOrder> createState() => _AcceptedOrderState();
}

class _AcceptedOrderState extends State<AcceptedOrder> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String cusId;
  bool loading = false;

  List<OrderHistoryModel> orderHistory = [];

  @override
  void initState() {
    dataHistoryOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: kTextColor,
            ),
            // heightFactor: 15.5,
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
              ),
              (orderHistory
                          .where(
                              (element) => element.customer.toString() == cusId)
                          .toList()
                          .length ==
                      0)
                  ? Center(
                      heightFactor: 2.2,
                      child: NothingToShowContainer(
                        iconPath: "assets/icons/empty-order.svg",
                        primaryMessage: "Kamu tidak memiliki riwayat pesanan",
                      ),
                    )
                  : Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        controller: _refreshController,
                        onRefresh: () => dataHistoryOrders(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              ...List.generate(
                                orderHistory.length,
                                (index) {
                                  if (orderHistory[index].customer.toString() ==
                                      cusId) {
                                    return OrderHistoryCard(
                                        orderHistory: orderHistory[index]);
                                  }
                                  return Container();
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(20)),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
  }

  Future<void> dataHistoryOrders() async {
    setState(() {
      loading = true;
    });

    cusId = await MyHelper.getPref(kId);

    var params = Map<String, dynamic>();

    var result = await API.get(API.dataOrderId, params);

    List<dynamic> tempOrderHistory = List<OrderHistoryModel>.from(
        result.map((x) => OrderHistoryModel.fromJson(x)));

    orderHistory = tempOrderHistory
        .where((element) => element.orderStatus == "Diterima")
        .toList();

    // orderHistory = List<OrderHistoryModel>.from(
    //     result.map((x) => OrderHistoryModel.fromJson(x)));

    setState(() {
      loading = false;
    });
  }
}

//Tab bar pesanan sudah bisa diambil

//Tab bar pesanan diterima
class ReadyToPickupOrder extends StatefulWidget {
  @override
  State<ReadyToPickupOrder> createState() => _ReadyToPickupOrderState();
}

class _ReadyToPickupOrderState extends State<ReadyToPickupOrder> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String cusId;
  bool loading = false;

  List<OrderHistoryModel> orderHistory = [];

  @override
  void initState() {
    dataHistoryOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: kTextColor,
            ),
            // heightFactor: 15.5,
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
              ),
              (orderHistory
                          .where(
                              (element) => element.customer.toString() == cusId)
                          .toList()
                          .length ==
                      0)
                  ? Center(
                      heightFactor: 2.2,
                      child: NothingToShowContainer(
                        iconPath: "assets/icons/empty-order.svg",
                        primaryMessage: "Kamu tidak memiliki riwayat pesanan",
                      ),
                    )
                  : Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        controller: _refreshController,
                        onRefresh: () => dataHistoryOrders(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              ...List.generate(
                                orderHistory.length,
                                (index) {
                                  if (orderHistory[index].customer.toString() ==
                                      cusId) {
                                    return OrderHistoryCard(
                                        orderHistory: orderHistory[index]);
                                  }
                                  return Container();
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(20)),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
  }

  Future<void> dataHistoryOrders() async {
    setState(() {
      loading = true;
    });

    cusId = await MyHelper.getPref(kId);

    var params = Map<String, dynamic>();

    var result = await API.get(API.dataOrderId, params);

    List<dynamic> tempOrderHistory = List<OrderHistoryModel>.from(
        result.map((x) => OrderHistoryModel.fromJson(x)));

    orderHistory = tempOrderHistory
        .where((element) => element.orderStatus == "Sudah Bisa Diambil")
        .toList();

    // orderHistory = List<OrderHistoryModel>.from(
    //     result.map((x) => OrderHistoryModel.fromJson(x)));

    setState(() {
      loading = false;
    });
  }
}

//Tab bar pesanan selesai
class FinishedOrder extends StatefulWidget {
  @override
  State<FinishedOrder> createState() => _FinishedOrderState();
}

class _FinishedOrderState extends State<FinishedOrder> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String cusId;
  bool loading = false;

  List<OrderHistoryModel> orderHistory = [];

  @override
  void initState() {
    dataHistoryOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: kTextColor,
            ),
            // heightFactor: 15.5,
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
              ),
              (orderHistory
                          .where(
                              (element) => element.customer.toString() == cusId)
                          .toList()
                          .length ==
                      0)
                  ? Center(
                      heightFactor: 2.2,
                      child: NothingToShowContainer(
                        iconPath: "assets/icons/empty-order.svg",
                        primaryMessage: "Kamu tidak memiliki riwayat pesanan",
                      ),
                    )
                  : Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        controller: _refreshController,
                        onRefresh: () => dataHistoryOrders(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              ...List.generate(
                                orderHistory.length,
                                (index) {
                                  if (orderHistory[index].customer.toString() ==
                                      cusId) {
                                    return OrderHistoryCard(
                                        orderHistory: orderHistory[index]);
                                  }
                                  return Container();
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(20)),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
  }

  Future<void> dataHistoryOrders() async {
    setState(() {
      loading = true;
    });

    cusId = await MyHelper.getPref(kId);

    var params = Map<String, dynamic>();

    var result = await API.get(API.dataOrderId, params);

    List<dynamic> tempOrderHistory = List<OrderHistoryModel>.from(
        result.map((x) => OrderHistoryModel.fromJson(x)));

    orderHistory = tempOrderHistory
        .where((element) => element.orderStatus == "Selesai")
        .toList();

    // orderHistory = List<OrderHistoryModel>.from(
    //     result.map((x) => OrderHistoryModel.fromJson(x)));

    setState(() {
      loading = false;
    });
  }
}

//Tab bar pesanan ditolak
class RejectedOrder extends StatefulWidget {
  @override
  State<RejectedOrder> createState() => _RejectedOrderState();
}

class _RejectedOrderState extends State<RejectedOrder> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String cusId;
  bool loading = false;

  List<OrderHistoryModel> orderHistory = [];

  @override
  void initState() {
    dataHistoryOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: kTextColor,
            ),
            // heightFactor: 15.5,
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
              ),
              (orderHistory
                          .where(
                              (element) => element.customer.toString() == cusId)
                          .toList()
                          .length ==
                      0)
                  ? Center(
                      heightFactor: 2.2,
                      child: NothingToShowContainer(
                        iconPath: "assets/icons/empty-order.svg",
                        primaryMessage: "Kamu tidak memiliki riwayat pesanan",
                      ),
                    )
                  : Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        controller: _refreshController,
                        onRefresh: () => dataHistoryOrders(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              ...List.generate(
                                orderHistory.length,
                                (index) {
                                  if (orderHistory[index].customer.toString() ==
                                      cusId) {
                                    return OrderHistoryCard(
                                        orderHistory: orderHistory[index]);
                                  }
                                  return Container();
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(20)),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
  }

  Future<void> dataHistoryOrders() async {
    setState(() {
      loading = true;
    });

    cusId = await MyHelper.getPref(kId);

    var params = Map<String, dynamic>();

    var result = await API.get(API.dataOrderId, params);

    List<dynamic> tempOrderHistory = List<OrderHistoryModel>.from(
        result.map((x) => OrderHistoryModel.fromJson(x)));

    orderHistory = tempOrderHistory
        .where((element) => element.orderStatus == "Ditolak")
        .toList();

    // orderHistory = List<OrderHistoryModel>.from(
    //     result.map((x) => OrderHistoryModel.fromJson(x)));

    setState(() {
      loading = false;
    });
  }
}

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({
    Key key,
    this.width = 350,
    this.aspectRatio = 1,
    @required this.orderHistory,
  }) : super(key: key);

  final double width, aspectRatio;

  final OrderHistoryModel orderHistory;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            OrderDetailScreen.routeName,
            arguments: OrderHistoryArguments(orderHistory: orderHistory),
          );
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 88,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  child: Icon(Icons.receipt_long_rounded, size: 60),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      orderHistory.orderId,
                      style: TextStyle(color: Colors.black, fontSize: 17),
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: DateFormat('dd-MMM-yyyy')
                                .format(orderHistory.createdAt),
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ),
                        orderHistory.orderStatus == "Belum Dikonfirmasi"
                            ? Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: kTextColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text("${orderHistory.orderStatus}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)),
                              )
                            : orderHistory.orderStatus == "Diterima"
                                ? Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text("${orderHistory.orderStatus}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10)),
                                  )
                                : orderHistory.orderStatus ==
                                        "Sudah Bisa Diambil"
                                    ? Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                            "${orderHistory.orderStatus}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)),
                                      )
                                    : orderHistory.orderStatus == "Selesai"
                                        ? Container(
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                                "${orderHistory.orderStatus}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10)),
                                          )
                                        : Container(
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                                "${orderHistory.orderStatus}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10)),
                                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
