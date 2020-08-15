import 'dart:convert';

import 'package:book_database/data/api/category_api.dart';
import 'package:book_database/models/category.dart';
import 'package:flutter/material.dart';

class CategoryUpdateWidgets extends StatefulWidget {
  @override
  _CategoryUpdateWidgetsState createState() => _CategoryUpdateWidgetsState();
}

class _CategoryUpdateWidgetsState extends State<CategoryUpdateWidgets> {

  // consts
  double rowSpaceWidth = 5.0;
  double rowSpaceHeight = 5.0;
  Color flatButtonTextColor = Colors.white;
  Color flatButtonColor = Colors.pink;

  // lists
  List<Category> _categories = new List<Category>();
  List<DropdownMenuItem<Category>> _categoryItems = new List<DropdownMenuItem<Category>>();
  Category _selectedCategory;

  // states
  bool _buttonsVisibleState = false;
  bool _updateFieldState = false;

  // controllers
  TextEditingController _categoryNameController;

  // messages
  String _message = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryNameController = TextEditingController();
    getCategoriesFromApi();
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
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          buildFirstRow(),
          _updateFieldState == true ? buildSecondRow() :  Container(),
          _buttonsVisibleState == true ? buildThirthRow() : Container(),
          buildMessageRow(),
        ],
      ),
    );
  }

  buildFirstRow() {
    return Padding(
      padding: EdgeInsets.only(top: rowSpaceHeight,  bottom:rowSpaceHeight),
      child: Row(
        children: <Widget>[
          Text("Kategori",style: _customTextStyle(),),
          SizedBox(width: 50.0,),
          buildDDMenu(),
        ],
      ),
    );
  }

  buildDDMenu() {
    return DropdownButton(
      items: _categoryItems,
      value: _selectedCategory,
      onChanged: (selectedCategory)=>onChangedCategoryItem(selectedCategory),
    );
  }

  void getCategoriesFromApi() {
    CategoryApi.getCategoriesAll().then((categories) {
      setState(() {
        this._categories = categories;
        _selectedCategory = _categories[0];
        getCategoryWidgets();
      });
    });
  }

  List<DropdownMenuItem<Category>> getCategoryWidgets() {
    for(Category category in _categories){
      _categoryItems.add(getCategoryWidget(category));
    }
    return _categoryItems;
  }

  DropdownMenuItem<Category> getCategoryWidget(Category category) {
    return DropdownMenuItem(
      child: Text(category.category_name),
      value: category,
    );
  }

  onChangedCategoryItem(selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
      _buttonsVisibleState = true;
    });
  }

  _customTextStyle() {
    return TextStyle(
      color: Colors.pink,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    );
  }

  buildThirthRow() {
    return Padding(
      padding: EdgeInsets.only(top: rowSpaceHeight,bottom:rowSpaceHeight),
      child: Row(
        children: <Widget>[

          _buttonsVisibleState == true ? buildUpdateButton() : Container(),
          SizedBox(width: 10.0,),
          _buttonsVisibleState == true ? buildDeleteButton() : Container(),

        ],
      ),
    );
  }

  buildUpdateButton() {
    return FlatButton(
      child: Text("Güncelle"),
      color: flatButtonColor,
      textColor: flatButtonTextColor,
      onPressed: _categoryUpdateButtonClicked,
    );
  }

  buildDeleteButton() {
    return FlatButton(
      child: Text("Sil"),
      color: flatButtonColor,
      textColor: flatButtonTextColor,
      onPressed: _categoryDeleteButtonClicked,
    );
  }



  void _categoryUpdateButtonClicked() {
    // kategori güncelleyen butona basıldığında burası çalışacak
    setState(() {
      _updateFieldState = true;
      if(_categoryNameController.text!=""){
        // kategori güncelleyen api çalışacak
        CategoryApi.categoryUpdate(_selectedCategory.category_id.toString(), _categoryNameController.text)
            .then((response) {
              setState(() {
                var jsonData = jsonDecode(response.body);
                _message = jsonData["message"];
                _categories.clear();
                _categoryItems.clear();
                getCategoriesFromApi();
              });
        });
      }
    });
  }

  void _categoryDeleteButtonClicked() {
    // kategori sil butona basıldığında burası çalışacak
    CategoryApi.categoryDelete(_selectedCategory.category_id.toString()).then((response) {
      setState(() {
        var jsonData = jsonDecode(response.body);
        _message = jsonData["message"];
        _categories.clear();
        _categoryItems.clear();
        getCategoriesFromApi();
      });
    });
  }

  buildSecondRow() {
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

  buildMessageRow() {
    return Text(
      _message,
      style: _customTextStyle(),
    );
  }
}
