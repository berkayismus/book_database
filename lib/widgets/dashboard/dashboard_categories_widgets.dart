import 'package:book_database/data/api/category_api.dart';
import 'package:book_database/models/category.dart';
import 'package:flutter/material.dart';

class DashBoardCategoriesWidgets extends StatefulWidget {
  @override
  _DashBoardCategoriesWidgetsState createState() => _DashBoardCategoriesWidgetsState();
}

class _DashBoardCategoriesWidgetsState extends State<DashBoardCategoriesWidgets> {

  // kategorileri tutacak list oluşturalım
  List<Category> _categoryList = List<Category>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoriesFromApi();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index){
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_categoryList[index].category_name,style: _customTextStyle(),),
            ],
          ),
        ),
      );
    },
      itemCount: _categoryList.length,
    );
  }

  void getCategoriesFromApi() {
    // gelen value List<Category> içeriyor
    CategoryApi.getCategoriesAll().then((value) {
      setState(() {
        _categoryList.addAll(value);
      });
  });
  }

  buildFirstRow() {

  }

  _customTextStyle() {
    return TextStyle(
      color: Colors.pink,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    );
  }




  

}
