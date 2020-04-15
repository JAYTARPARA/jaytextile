import 'package:flutter/material.dart';
import 'package:jaytextile/screens/help.dart';

class DarkTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.map,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return HelpPage();
                },
              ),
            );
          },
        ),

        // IconButton(
        //   icon: Icon(
        //     Icons.home,
        //     size: 30.0,
        //   ),
        //   onPressed: () {
        //     Navigator.popUntil(
        //       context,
        //       ModalRoute.withName('/home'),
        //       // (route) => false,
        //     );
        //     // Navigator.pushNamedAndRemoveUntil(
        //     //   context,
        //     //   "/home",
        //     //   (r) => false,
        //     // );
        //   },
        // ),
      ],
      // children: <Widget>[
      //   GFToggle(
      //     onChanged: (v) async {
      //       if (v) {
      //         Provider.of<AppProvider>(context, listen: false)
      //             .setTheme(Constants.darkTheme, "dark");
      //       } else {
      //         Provider.of<AppProvider>(context, listen: false)
      //             .setTheme(Constants.lightTheme, "light");
      //       }
      //     },
      //     value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
      //         ? false
      //         : true,
      //     type: GFToggleType.ios,
      //     enabledThumbColor: Colors.black,
      //     enabledTrackColor: Colors.white,
      //     disabledThumbColor: Colors.white,
      //     disabledTrackColor: Colors.black,
      //   ),
      // ],
    );
    // Switch(
    //   value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
    //       ? false
    //       : true,
    //   onChanged: (v) async {
    //     if (v) {
    //       Provider.of<AppProvider>(context, listen: false)
    //           .setTheme(Constants.darkTheme, "dark");
    //     } else {
    //       Provider.of<AppProvider>(context, listen: false)
    //           .setTheme(Constants.lightTheme, "light");
    //     }
    //   },
    //   activeColor: Theme.of(context).accentColor,
    // );
  }
}
