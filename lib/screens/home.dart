import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jaytextile/screens/furnitures.dart';
import 'package:jaytextile/services/common.dart';
import 'package:jaytextile/sidebar/sidebar.dart';
import 'package:jaytextile/widgets/dark_theme.dart';
import 'package:jaytextile/widgets/grid_product.dart';
import 'package:jaytextile/widgets/home_category.dart';
import 'package:jaytextile/widgets/slider_item.dart';
import 'package:jaytextile/util/furnitures.dart';
import 'package:jaytextile/util/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jaytextile/widgets/whatsapp.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List sliderProducts = [];
  List collectionProducts = [];
  List productCategories = [];
  bool loadSlider = true;
  bool loadCollection = true;
  bool loadCategories = true;
  bool showLoadMore = false;
  bool loadingRunning = false;
  int showMorePage = 2;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    getAllProducts();
    getAllProductCategories();
    getSliderProducts();
    // print(products.length);
  }

  Future getAllProducts() async {
    var prodAll = await Common().getAllProducts();

    for (var i = 0; i < prodAll.length; i++) {
      var collectionProductsMap = {
        'id': prodAll[i]['id'],
        'image': prodAll[i]["images"][0]["src"],
        'price': prodAll[i]["price"],
        'name': prodAll[i]["name"],
      };
      collectionProducts.add(collectionProductsMap);
    }

    setState(() {
      loadCollection = false;
      if (prodAll.length >= 15) {
        showLoadMore = true;
      }
    });
  }

  Future getSliderProducts() async {
    var prodSlider = await Common().getSliderProducts();

    for (var i = 0; i < prodSlider.length; i++) {
      var sliderProductsMap = {
        'id': prodSlider[i]['id'],
        'image': prodSlider[i]["images"][0]["src"],
      };
      sliderProducts.add(sliderProductsMap);
    }

    setState(() {
      loadSlider = false;
    });
  }

  Future getAllProductCategories() async {
    var prodCategories = await Common().getProductCategories();

    for (var i = 0; i < prodCategories.length; i++) {
      if (prodCategories[i]['id'] != 21 && prodCategories[i]['id'] != 94) {
        productCategories.add(prodCategories[i]);
      }
    }

    setState(() {
      loadCategories = false;
    });
  }

  Future loadMoreProducts(page) async {
    setState(() {
      loadingRunning = true;
    });

    var prodLoadMore = await Common().loadMoreProducts(page);

    if (prodLoadMore.length == 0) {
      setState(() {
        showLoadMore = false;
      });
    } else {
      for (var i = 0; i < prodLoadMore.length; i++) {
        var collectionProductsMapNew = {
          'id': prodLoadMore[i]['id'],
          'image': prodLoadMore[i]["images"][0]["src"],
          'price': prodLoadMore[i]["price"],
          'name': prodLoadMore[i]["name"],
        };
        collectionProducts.add(collectionProductsMapNew);
      }
      if (prodLoadMore.length < 15) {
        setState(() {
          showLoadMore = false;
        });
      }
    }
    setState(() {
      loadingRunning = false;
      showMorePage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: Whatsapp(),
      appBar: AppBar(
        title: Text('JAY TEXTILE'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        actions: <Widget>[
          DarkTheme(),
        ],
      ),
      // drawer: Sidebar(),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Press again to exit'),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            10.0,
            0.0,
            10.0,
            0.0,
          ),
          child: ListView(
            children: <Widget>[
              //Slider Here
              loadSlider
                  ? Container(
                      height: MediaQuery.of(context).size.height / 2.4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                  : CarouselSlider.builder(
                      height: MediaQuery.of(context).size.height / 2.4,
                      itemCount: sliderProducts.length,
                      itemBuilder: (BuildContext context, int itemIndex) {
                        return Container(
                          margin: EdgeInsets.all(5.0),
                          child: CachedNetworkImage(
                            imageUrl: sliderProducts[itemIndex]['image'],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SpinKitWave(
                                    // color: Colors.white,
                                    color: Theme.of(context).accentColor,
                                    size: 50.0,
                                  ),
                                ],
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          // decoration: BoxDecoration(
                          //   image:
                          //    DecorationImage(
                          //     image: NetworkImage(
                          //         sliderProducts[itemIndex]['image']),
                          //     fit: BoxFit.cover,
                          //   ),
                          //   borderRadius: BorderRadius.circular(10.0),
                          // ),
                        );
                      },
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: Duration(seconds: 10),
                      enlargeCenterPage: false,
                    ),
              SizedBox(height: 20.0),
              Text(
                "CATEGORIES",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              loadCategories
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SpinKitWave(
                            color: Theme.of(context).accentColor,
                            size: 30.0,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: 65.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: productCategories == null
                            ? 0
                            : productCategories.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map cat = productCategories[index];
                          return HomeCategory(
                            id: cat['id'],
                            icon: cat['icon'],
                            title: cat['name'],
                            items: cat['count'],
                            isHome: true,
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "OUR COLLECTION",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              loadCollection
                  ? Container(
                      height: MediaQuery.of(context).size.height / 2.4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                  : GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      //physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.25),
                      ),
                      itemCount: collectionProducts == null
                          ? 0
                          : collectionProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map collection = collectionProducts[index];
                        return GridProduct(
                          id: collection['id'],
                          img: collection['image'],
                          isFav: false,
                          name: collection['name'],
                          price: collection['price'],
                        );
                      },
                    ),
              showLoadMore
                  ? RaisedButton(
                      child: loadingRunning
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SpinKitWave(
                                    // color: Colors.white,
                                    color: Theme.of(context).primaryColor,
                                    size: 20.0,
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              "Load More".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // color: Colors.white,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                      // shape: StadiumBorder(),
                      padding: const EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        // side: BorderSide(color: Colors.black87),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        loadMoreProducts(showMorePage);
                      },
                    )
                  : Container(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
