import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:jaytextile/providers/app_provider.dart';
import 'package:jaytextile/util/const.dart';
import 'package:provider/provider.dart';

class DarkTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GFToggle(
          onChanged: (v) async {
            if (v) {
              Provider.of<AppProvider>(context, listen: false)
                  .setTheme(Constants.darkTheme, "dark");
            } else {
              Provider.of<AppProvider>(context, listen: false)
                  .setTheme(Constants.lightTheme, "light");
            }
          },
          value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
              ? false
              : true,
          type: GFToggleType.ios,
          enabledThumbColor: Colors.black,
          enabledTrackColor: Colors.white,
          disabledThumbColor: Colors.white,
          disabledTrackColor: Colors.black,
        ),
      ],
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
