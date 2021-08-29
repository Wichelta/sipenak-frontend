import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sipenak_app/api/api.dart';
import 'dart:ui';
import 'package:sipenak_app/screens/details/details_screen.dart';
import 'package:sipenak_app/models/home/product_model.dart';
import 'package:sipenak_app/components/nothingtoshow_container.dart';

import '../../../size_config.dart';
import 'home_header.dart';
import 'section_title.dart';
import '../../../constants.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool loading = false;

  List<ProductModel> product = [];

  @override
  void initState() {
    dataProduct();
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
            heightFactor: 35,
          )
        : Column(
            children: [
              Container(
                color: Colors.white,
                height: 100,
                child: HomeHeader(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15)),
                child: SectionTitle(title: "Semua Produk"),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              (product
                          .where((element) => element.available == true)
                          .toList()
                          .length ==
                      0)
                  ? Center(
                      heightFactor: 2.2,
                      child: NothingToShowContainer(
                        iconPath: "assets/icons/empty-product.svg",
                        primaryMessage: "Maaf, tidak ada produk untuk saat ini",
                      ),
                    )
                  : Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        controller: _refreshController,
                        onRefresh: () => dataProduct(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              ...List.generate(
                                product.length,
                                (index) {
                                  if (product[index].available) {
                                    return ProductCard(product: product[index]);
                                  }
                                  return Container();
                                },
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
  }

  Future<void> dataProduct() async {
    setState(() {
      loading = true;
    });

    var params = Map<String, dynamic>();

    var result = await API.get(API.dataProduct, params);

    product =
        List<ProductModel>.from(result.map((x) => ProductModel.fromJson(x)));

    setState(() {
      loading = false;
    });
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 350,
    this.aspectRatio = 1,
    @required this.product,
  }) : super(key: key);

  final double width, aspectRatio;

  final ProductModel product;

  // final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 8,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: product),
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
                  child: product.productPhoto == null
                      ? SizedBox()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            product.productPhoto,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.productName,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Rp ' + product.price.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                            ),
                            children: [
                              TextSpan(
                                text: "/" + product.unit,
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("${product.category}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
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
