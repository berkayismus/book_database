import 'dart:convert';

import 'package:book_database/data/api/book_api.dart';
import 'package:book_database/data/api/category_api.dart';
import 'package:book_database/models/book.dart';
import 'package:book_database/models/category.dart';
import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatefulWidget {
  String categoryIndex;
  CategoryDetailScreen(this.categoryIndex);

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState(categoryIndex);
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {

  // dashboard ekranında kategorilere tıklandığında bu sayfaya constructor vasıtasıyla bir index değeri gelecek
  // bu categoryIndex değeri ile tıklanan kategorinin ID'sini alabileceğiz
  String categoryIndex;
  _CategoryDetailScreenState(this.categoryIndex);

  // kategoriye göre kitapları getirelim
  List<Book> _bookList = List<Book>();
  bool bookListState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooksByCategoryId();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategori Detay Sayfası"),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: bookListState==true ? buildBooksListView() : Container(),
    );
  }

  buildBooksListView() {
    return ListView.builder(
        itemCount: _bookList.length,
        itemBuilder: (context,index){
      return ListTile(
        leading: Icon(Icons.book),
        trailing: Icon(Icons.arrow_forward),
        title: Text("${index+1} - " + _bookList[index].book_name,style: _customBookNameStyle(),),
        subtitle: Text(_bookList[index].book_detail.length>150 ? _bookList[index].book_detail.substring(0,150) + "..." : _bookList[index].book_detail,style: _customBookDetailStyle(),),
        onTap: (){_bookClicked(index);},
      );
    });
  }





  void getBooksByCategoryId() {
    // kategori id'e göre kitapları getiren async fonksiyon
    BookApi.getBooksByCategoryId("${categoryIndex}").then((response) {
      setState(() {
        Iterable bookList = jsonDecode(response.body);
        this._bookList = bookList.map((book) => Book.fromJson(book)).toList();
        bookListState = true;
        //debugPrint(categoryIndex.toString());// yanlış gösteriyor
      });
    });
  }

  void _bookClicked(int index) {
    //debugPrint("${_bookList[index].book_name} kitabına tıklandı");
    Navigator.pushNamed(context, "/bookDetail/${_bookList[index].book_id}");
  }

  _customBookNameStyle() {
    return TextStyle(
        color: Colors.red,
        fontSize: 18,
        fontWeight: FontWeight.bold
    );
  }

  _customBookDetailStyle() {
    return TextStyle(
        color: Colors.teal,
        fontSize: 14,
        fontWeight: FontWeight.bold
    );
  }
}

