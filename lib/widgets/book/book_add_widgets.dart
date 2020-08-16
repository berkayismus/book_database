import 'dart:convert';

import 'package:book_database/data/api/book_api.dart';
import 'package:book_database/data/api/category_api.dart';
import 'package:book_database/models/book.dart';
import 'package:book_database/models/category.dart';
import 'package:flutter/material.dart';

class BookAddWidgets extends StatefulWidget {
  @override
  _BookAddWidgetsState createState() => _BookAddWidgetsState();
}

class _BookAddWidgetsState extends State<BookAddWidgets> {
  // consts
  final double fieldSpaceHeight = 5.0;
  final double fieldSpaceWidth = 5.0;

  // controllers for text fields
  TextEditingController _bookNameController;
  TextEditingController _bookDetailController;
  TextEditingController _bookPageNumberController;
  TextEditingController _bookPublisherController;
  TextEditingController _bookAuthorNameController;
  
  // lists
  List<Category> _categories = new List<Category>();
  List<DropdownMenuItem<Category>> _categoryItems = new List<DropdownMenuItem<Category>>();
  Category _selectedCategory;

  // messages
  String _message="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookNameController = TextEditingController();
    _bookDetailController = TextEditingController();
    _bookPageNumberController = TextEditingController();
    _bookPublisherController = TextEditingController();
    _bookAuthorNameController = TextEditingController();
    getCategoriesFromApi();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bookNameController.dispose();
    _bookDetailController.dispose();
    _bookPageNumberController.dispose();
    _bookPublisherController.dispose();
    _bookAuthorNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          buildCategoryField(),
          buildBookNameField(),
          buildBookDetailField(),
          bookAuthorNameField(),
          buildBookPageNumberField(),
          buildBookPublisherField(),
          //buildBookTotalScoreField(),
          //buildBookTotalRepField(),
          //buildBookAverageScoreField(),
          buildButtonsField(),
          buildMessageField(),

        ],
      ),
    );
  }

  buildCategoryField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Text("Kategori",style: _customTextStyle(),),
          SizedBox(width: 20.0,),
          _buildDDMenu(),
        ],
      )
    );
  }

  buildBookNameField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _bookNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Kitap Adı",
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildBookDetailField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 5,
              controller: _bookDetailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Kitap Açıklaması",
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildBookPageNumberField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: _bookPageNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Sayfa Sayısı",
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildBookPublisherField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: _bookPublisherController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Yayıncı Adı",
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildButtonsField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Text("Ekle"),
            color: Colors.pink,
            textColor: Colors.white,
            onPressed: _bookAddClicked,
          ),
          SizedBox(width: 5,),
          FlatButton(
            child: Text("Temizle"),
            color: Colors.pink,
            textColor: Colors.white,
            onPressed: _bookResetClicked,
          ),
        ],
      ),
    );
  }

  void _bookAddClicked() {
    // kitap ekleme butonuna basıldığında burası çalışacak
    String bookName = _bookNameController.text;
    String bookDetail = _bookDetailController.text;
    int bookPageNumber = int.tryParse(_bookPageNumberController.text);
    String bookPublisher = _bookPublisherController.text;
    int bookStatus = 1;
    double bookTotalScore = 10;
    double bookTotalRep = 2;
    double bookAverageScore = 5;
    String categoryId = _selectedCategory.category_id;
    String bookAuthor = _bookAuthorNameController.text;



    Book newBook = Book.forAdd(bookName,bookDetail,bookPageNumber,bookPublisher,bookStatus,
        bookTotalScore,bookTotalRep,bookAverageScore,
    categoryId,bookAuthor);
    /* debugPrint(
        newBook.book_name + "\n"
    + newBook.book_detail + "\n"
    + newBook.book_page_number.toString() + "\n"
        + newBook.book_publisher + "\n"
        + newBook.book_status.toString() + "\n"
        + newBook.book_total_score.toString() + "\n"
        + newBook.book_total_rep.toString() + "\n"
        + newBook.book_average_score.toString() + "\n"
        + newBook.category_id + "\n"
        + newBook.book_author
    ); */

      BookApi.addBook(newBook).then((response) {
        setState(() {
          var jsonData = jsonDecode(response.body);
          _message = jsonData["message"];
        });
      });

  }

  void _bookResetClicked() {
    // temizle butonuna basıldığında burası çalışacak

    setState(() {
      _bookNameController.text = "";
      _bookDetailController.text = "";
      _bookPageNumberController.text = "";
      _bookPublisherController.text = "";
      _bookAuthorNameController.text = "";
      _message = "";
    });


  }

  bookAuthorNameField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: _bookAuthorNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Yazar Adı",
              ),
            ),
          ),
        ],
      ),
    );
  }


  void getCategoriesFromApi() {
    CategoryApi.getCategoriesAll().then((categoryList) {
      setState(() {
        this._categories = categoryList;
        this._selectedCategory = _categories[0];
        getCategoryWidgets();
      });
    });
  }

  List<DropdownMenuItem<Category>> getCategoryWidgets() {
    for(Category category in _categories){
      _categoryItems.add(getCategoryItem(category));
    }
    return _categoryItems;
  }

  Widget getCategoryItem(Category category) {
    return DropdownMenuItem(
      child: Text(category.category_name),
      value: category,
    );
  }

  onChangedCategory(value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  _buildDDMenu(){
    return DropdownButton(
      items: _categoryItems,
      onChanged: (value) => onChangedCategory(value),
      value: _selectedCategory,
    );
  }

  _customTextStyle() {
    return TextStyle(
      color: Colors.pink,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  buildMessageField() {
    return Padding(
      padding: EdgeInsets.only(bottom:fieldSpaceHeight ,top: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Text(_message,style: _customTextStyle(),),
        ],
      ),
    );
  }


}
