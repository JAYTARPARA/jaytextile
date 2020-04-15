import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jaytextile/services/common.dart';

class Whatsapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: "Chat on whatsapp",
      child: Icon(
        FontAwesomeIcons.whatsapp,
        color: Colors.white,
      ),
      backgroundColor: Colors.green,
      foregroundColor: Colors.green,
      elevation: 15.0,
      onPressed: () {
        FlutterOpenWhatsapp.sendSingleMessage(
          Common().mobile,
          Common().commonMsg,
        );
      },
    );
  }
}
