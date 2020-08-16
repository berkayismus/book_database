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
    return buildCategoryListView();
  }

  void getCategoriesFromApi() {
    // gelen value List<Category> içeriyor
    CategoryApi.getCategoriesAll().then((value) {
      setState(() {
        _categoryList.addAll(value);
      });
  });
  }

  buildCategoryListView() {
    return ListView.builder(itemBuilder: (context,index){
      return buildCategoryCardItem(context,index);
    },
      itemCount: _categoryList.length,
    );
  }

  _customTextStyle() {
    return TextStyle(
      color: Colors.pink,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    );
  }

  buildCategoryCardItem(BuildContext context, int index) {
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: (){categoryItemClicked(context,index);},
        title: Text(_categoryList[index].category_name,style: _customTextStyle(),),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }

  void categoryItemClicked(BuildContext context, int index) {
        String currentCategoryId = _categoryList[index].category_id;
        Navigator.pushNamed(context, "/categoryDetail/"+currentCategoryId);
  }




  
}
