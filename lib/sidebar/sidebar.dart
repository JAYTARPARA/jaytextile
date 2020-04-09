import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:jaytextile/providers/app_provider.dart';
import 'package:jaytextile/util/const.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userMobile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _createHeader(context),
          _customerMenu(context),
        ],
      ),
    );
  }
}

Widget _customerMenu(context) {
  return Container(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        ListTile(
          title: Text(
            "Dark Theme",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: Icon(
            Icons.brightness_medium,
            size: 30,
          ),
          trailing: Switch(
            value:
                Provider.of<AppProvider>(context).theme == Constants.lightTheme
                    ? false
                    : true,
            onChanged: (v) async {
              if (v) {
                Provider.of<AppProvider>(context, listen: false)
                    .setTheme(Constants.darkTheme, "dark");
              } else {
                Provider.of<AppProvider>(context, listen: false)
                    .setTheme(Constants.lightTheme, "light");
              }
            },
            activeColor: Theme.of(context).accentColor,
          ),
        ),
        // Divider(
        //   height: 50,
        //   thickness: 0.5,
        //   color: Colors.white.withOpacity(0.3),
        //   indent: 15,
        //   endIndent: 15,
        // ),
      ],
    ),
  );
}

Widget _createHeader(context) {
  return Container(
    height: 200.0,
    child: DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        // color: Colors.black87,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/sidebar_header.jpg',
          ),
        ),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            CircularProfileAvatar(
              'https://i.ibb.co/MgsKf7Y/coach.png',
              radius: 60,
              cacheImage: true,
              backgroundColor: Colors.transparent,
              borderWidth: 3,
              borderColor: Colors.white,
              elevation: 5.0,
              foregroundColor: Colors.black87.withOpacity(0.5),
              showInitialTextAbovePicture: true,
            ),
          ],
        ),
      ),
    ),
  );
}
