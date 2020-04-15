import 'package:flutter/material.dart';
import 'package:jaytextile/util/furnitures.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with AutomaticKeepAliveClientMixin<SearchScreen>{
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),

          Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Search..",
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),

          SizedBox(height: 5.0),

          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "History",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: furnitures == null ? 0 :furnitures.length,
            itemBuilder: (BuildContext context, int index) {
              Map food = furnitures[index];
              return ListTile(
                title: Text(
                  "${food['name']}",
                  style: TextStyle(
//                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage(
                    "${food['img']}",
                  ),
                ),
                trailing: Text(r"$25"),
                // subtitle:  
                onTap: (){},
              );
            },
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
