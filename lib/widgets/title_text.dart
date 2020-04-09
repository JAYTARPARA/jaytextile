import 'package:flutter/material.dart';
import 'package:jaytextile/util/light_color.dart';


class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const TitleText(
      {Key key,
        this.text,
        this.fontSize = 18,
        this.color = LightColor.titleTextColor,
        this.fontWeight = FontWeight.w800
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,);
  }
}