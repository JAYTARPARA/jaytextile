import 'package:flutter/material.dart';
import 'package:jaytextile/util/const.dart';

class CustomTitle extends StatelessWidget {
  final title;
  CustomTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Constants.darkBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
