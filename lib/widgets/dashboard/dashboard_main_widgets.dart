import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardMainWidgets extends StatefulWidget {
  @override
  _DashBoardMainWidgetsState createState() => _DashBoardMainWidgetsState();
}

class _DashBoardMainWidgetsState extends State<DashBoardMainWidgets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          buildFirstRow(),
        ],
      ),
    );
  }

  buildFirstRow() {
    return Padding(
      padding: EdgeInsets.only(top: 5,bottom: 5),
      child: Row(
        children: <Widget>[
          Text("AnaSayfa"),
        ],
      ),
    );
  }


}
