import 'dart:convert';

import 'package:book_database/data/api/category_api.dart';
import 'package:flutter/material.dart';

class CategoryAddWidgets extends StatefulWidget {
  @override
  _CategoryAddWidgetsState createState() => _CategoryAddWidgetsState();
}

class _CategoryAddWidgetsState extends State<CategoryAddWidgets> {

  // consts
  double rowSpaceWidth = 5.0;
  double rowSpaceHeight = 5.0;
  Color flatButtonTextColor = Colors.white;
  Color flatButtonColor = Colors.pink;

  // controllers
  TextEditingController _categoryNameController;

  // messages
  String _message="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryNameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categoryNameController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          buildFirstRow(),
          buildSecondRow(),
          buildThirthRow(),
        ],
      ),
    );
  }

  buildFirstRow() {
    return Padding(
      padding: EdgeInsets.only(top: rowSpaceHeight,bottom:rowSpaceHeight),
      child: Row(
        children: <Widget>[

          Expanded(
        child: TextField(
          controller: _categoryNameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Kategori Adı",
        ),
        ),
      ),

        ],
      ),
    );
  }

  buildSecondRow() {
    return Padding(
      padding: EdgeInsets.only(top: rowSpaceHeight,bottom:rowSpaceHeight),
      child: Row(
        children: <Widget>[

          FlatButton(
            child: Text("Ekle"),
            textColor: flatButtonTextColor,
            color: flatButtonColor,
            onPressed: _categoryAddClicked,
          ),

        ],
      ),
    );
  }

  void _categoryAddClicked() {
    CategoryApi.categoryAdd(_categoryNameController.text).then((response) {
      setState(() {
        var jsonData = jsonDecode(response.body);
        _message = jsonData["message"];
      });
    });
  }

  buildThirthRow() {
    return Padding(
      padding: EdgeInsets.only(top: rowSpaceHeight,bottom:rowSpaceHeight),
      child: Row(
        children: <Widget>[

          Text(_message,style: _customTextStyle(),),

        ],
      ),
    );
  }

  _customTextStyle() {
    return TextStyle(
      color: Colors.pink,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
  }
}
