import 'package:flutter/material.dart';
import 'package:jaytextile/screens/details.dart';
import 'package:jaytextile/util/const.dart';

class SliderItem extends StatelessWidget {
  final String name;
  final String img;
  final bool isFav;

  SliderItem({
    Key key,
    @required this.name,
    @required this.img,
    @required this.isFav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "$img",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: -10.0,
                bottom: 3.0,
                child: RawMaterialButton(
                  onPressed: () {},
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Theme.of(context).accentColor,
                      size: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 2.0, top: 10.0),
          //   child: Text(
          //     "$name",
          //     style: TextStyle(
          //       fontSize: 20.0,
          //       fontWeight: FontWeight.w900,
          //     ),
          //     maxLines: 2,
          //   ),
          // ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetails(
                productName: name,
                productImageAsset: img,
              );
            },
          ),
        );
      },
    );
  }
}
