import 'package:flutter/material.dart';
import 'package:jaytextile/util/furnitures.dart';
import 'package:jaytextile/widgets/grid_product.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class FurnitureScreen extends StatefulWidget {
  @override
  _FurnitureScreenState createState() => _FurnitureScreenState();
}

class _FurnitureScreenState extends State<FurnitureScreen> {
  Future getProducts() async {
    /// Initialize the API
    WooCommerceAPI wc_api = new WooCommerceAPI(
      "http://textile.jaytarpara.in",
      "ck_7b4ff0cb8989b3f2595414dfa4d2782c70c84130",
      "cs_495fec8a56ffc6581d4b9255a4ec5e34683769f4",
    );

    /// Get data using the endpoint
    var p = await wc_api.getAsync("products");
    print(p);
    print('LENGTH: ');
    print(p.length);
    return p;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Furnitures",
        ),
        elevation: 0.0,
      ),
      body:  FutureBuilder(
                future: getProducts(),
                builder: (_, s) {
                  return ListView.builder(
                    itemCount: s.data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Image.network(
                            s.data[index]["images"][0]["src"],
                          ),
                        ),
                        title: Text(
                          s.data[index]["name"],
                        ),
                        subtitle: Text(
                          "Buy now for \$ " + s.data[index]["price"],
                        ),
                      );
                    },
                  );
                },
              ),
      // Padding(
      //   padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      //   child: ListView(
      //     children: <Widget>[
      //       GridView.builder(
      //         shrinkWrap: true,
      //         primary: false,
      //         physics: NeverScrollableScrollPhysics(),
      //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 2,
      //           childAspectRatio: MediaQuery.of(context).size.width /
      //               (MediaQuery.of(context).size.height / 1.25),
      //         ),
      //         itemCount: furnitures.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           Map food = furnitures[index];
      //           return GridProduct(
      //             img: food['img'],
      //             isFav: false,
      //             name: food['name'],
      //             rating: 5.0,
      //             raters: 23,
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
