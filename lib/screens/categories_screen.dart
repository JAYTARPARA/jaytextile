import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jaytextile/services/common.dart';
import 'package:jaytextile/util/categories.dart';
import 'package:jaytextile/util/furnitures.dart';
import 'package:jaytextile/widgets/dark_theme.dart';
import 'package:jaytextile/widgets/grid_product.dart';
import 'package:jaytextile/widgets/home_category.dart';
import 'package:jaytextile/widgets/whatsapp.dart';

class CategoriesScreen extends StatefulWidget {
  final categoryId;
  final categoryName;
  CategoriesScreen({Key key, this.categoryId, this.categoryName})
      : super(key: key);
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List categoryProducts = [];
  List subCategories = [];
  bool loadProducts = true;
  bool showLoadMore = false;
  bool loadingRunning = false;
  bool loadCategories = true;
  int showMorePage = 2;

  @override
  void initState() {
    super.initState();
    getSubCategories(widget.categoryId);
    getCategoryProducts(widget.categoryId);
  }

  Future getCategoryProducts(cid) async {
    var categoryProd = await Common().getCategoryProducts(cid);

    for (var i = 0; i < categoryProd.length; i++) {
      categoryProducts.add(categoryProd[i]);
    }

    setState(() {
      loadProducts = false;
      if (categoryProd.length >= 15) {
        showLoadMore = true;
      }
    });
  }

  Future getSubCategories(cid) async {
    var subCategory = await Common().getSubCategories(cid);

    for (var i = 0; i < subCategory.length; i++) {
      if (subCategory[i]['id'] != 21 && subCategory[i]['id'] != 94) {
        subCategories.add(subCategory[i]);
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

    var prodLoadMore = await Common().loadMoreProductsWithCategory(
      widget.categoryId,
      page,
    );

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
        categoryProducts.add(collectionProductsMapNew);
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
        title: Text(widget.categoryName.toString().toUpperCase()),
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
          0.0,
          10.0,
          0.0,
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: subCategories.length == 0 ? 0.0 : 15.0,
            ),
            subCategories.length == 0
                ? Container()
                : Text(
                    "CATEGORIES OF " +
                        widget.categoryName.toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
            SizedBox(
              height: subCategories.length == 0 ? 0.0 : 10.0,
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
                    height: subCategories.length == 0 ? 0.0 : 65.0,
                    child: subCategories.length == 0
                        ? Container()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: subCategories == null
                                ? 0
                                : subCategories.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map cat = subCategories[index];
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
            loadProducts
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
                : GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    //physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.25),
                    ),
                    itemCount:
                        categoryProducts == null ? 0 : categoryProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map collection = categoryProducts[index];
                      return GridProduct(
                        id: collection['id'],
                        img: collection['images'][0]['src'],
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
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                    padding: const EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      loadMoreProducts(showMorePage);
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
