import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jaytextile/services/common.dart';
import 'package:jaytextile/util/const.dart';
import 'package:jaytextile/util/light_color.dart';
import 'package:jaytextile/util/read_more_text.dart';
import 'package:jaytextile/widgets/dark_theme.dart';
import 'package:jaytextile/widgets/grid_product.dart';
import 'package:jaytextile/widgets/title_text.dart';
import 'package:getflutter/getflutter.dart';
import 'package:jaytextile/widgets/whatsapp.dart';

class ProductDetails extends StatefulWidget {
  final int id;
  final String productName;
  final String productImageAsset;
  final String productPrice;

  ProductDetails({
    Key key,
    this.id,
    this.productName,
    this.productImageAsset,
    this.productPrice,
  }) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFav = false;
  bool getDetails = true;
  bool getRelatedProduct = false;
  var productDetails;
  var relatedProducts;

  @override
  void initState() {
    super.initState();
    getProductDetails(widget.id);
  }

  Future getProductDetails(productID) async {
    productDetails = await Common().getProductDetails(productID);
    if (productDetails != null) {
      setState(() {
        getDetails = false;
      });
    }
    // print(productDetails['related_ids']);
    getRelatedProducts(productDetails['related_ids']);
  }

  Future getRelatedProducts(categoryID) async {
    setState(() {
      getRelatedProduct = true;
    });
    relatedProducts = await Common().getRelatedProduct(categoryID);
    if (relatedProducts != null) {
      setState(() {
        getRelatedProduct = false;
      });
    }
    // print(relatedProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Whatsapp(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          widget.productName,
        ),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        actions: <Widget>[
          DarkTheme(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          10.0,
          0,
          10.0,
          0,
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: getDetails
                      ? Container(
                          height: MediaQuery.of(context).size.height / 2.4,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SpinKitWave(
                                  color: Theme.of(context).accentColor,
                                  size: 50.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      : CarouselSlider.builder(
                          height: MediaQuery.of(context).size.height / 2.4,
                          itemCount: productDetails['images'].length,
                          itemBuilder: (BuildContext context, int itemIndex) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(5.0),
                              child: CachedNetworkImage(
                                imageUrl: productDetails['images'][itemIndex]
                                    ['src'],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SpinKitWave(
                                        color: Theme.of(context).accentColor,
                                        size: 50.0,
                                      ),
                                    ],
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            );
                          },
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: Duration(seconds: 10),
                          enlargeCenterPage: false,
                        ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.productName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5.0, top: 2.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "₹${widget.productPrice}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  getDetails
                      ? Container(
                          height: MediaQuery.of(context).size.height / 2.4,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SpinKitWave(
                                  // color: Colors.white,
                                  color: Theme.of(context).accentColor,
                                  size: 50.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Html(
                              data: productDetails['description'],
                              defaultTextStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Center(
                              child: RaisedButton.icon(
                                elevation: 3.0,
                                icon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 12.0,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.white,
                                  ),
                                ),
                                label: Text(
                                  "Order on Whatsapp".toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                // padding: const EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.green,
                                onPressed: () {
                                  var msg =
                                      "Hey, I want to buy this product and details are as below... \r\n\r\n";
                                  msg = msg +
                                      "*Name: Ready Made Product Two*  \r\n\r\n";
                                  msg = msg +
                                      "*Price: ₹" +
                                      widget.productPrice +
                                      "*  \r\n\r\n";
                                  msg = msg +
                                      "*URL: " +
                                      productDetails['permalink'] +
                                      "*  \r\n\r\n";
                                  FlutterOpenWhatsapp.sendSingleMessage(
                                    Common().mobile,
                                    msg,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            relatedProducts == null
                                ? Container()
                                : Text(
                                    "Related Products",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                            SizedBox(
                              height: 8.0,
                            ),
                            getRelatedProduct
                                ? Container(
                                    height: MediaQuery.of(context).size.height /
                                        2.4,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SpinKitWave(
                                            // color: Colors.white,
                                            color:
                                                Theme.of(context).accentColor,
                                            size: 50.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            MediaQuery.of(context).size.width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.25),
                                      ),
                                      itemCount: relatedProducts == null
                                          ? 0
                                          : relatedProducts.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Map collection = relatedProducts[index];
                                        return GridProduct(
                                          id: collection['id'],
                                          img: collection['images'][0]['src'],
                                          isFav: false,
                                          name: collection['name'],
                                          price: collection['price'],
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
