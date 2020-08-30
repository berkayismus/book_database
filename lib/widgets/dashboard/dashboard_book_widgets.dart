import 'dart:convert';

import 'package:book_database/data/api/book_api.dart';
import 'package:book_database/models/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardBookWidgets extends StatefulWidget {
  @override
  _DashBoardBookWidgetsState createState() => _DashBoardBookWidgetsState();
}

class _DashBoardBookWidgetsState extends State<DashBoardBookWidgets> {

  List<Book> _randomBooks = List<Book>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRandomBooksFromApi();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _randomBooks.length,
      itemBuilder: (context,index){
        return ListTile(
          leading: Icon(Icons.book),
          title: Text(_randomBooks[index].book_name,style: _customBookNameStyle(),),
          subtitle: Text(_randomBooks[index].book_detail.substring(0,150) + "..",style: _customBookDetailStyle(),),
          onTap: (){ _randomBookClicked(_randomBooks[index].book_id); },
        );
      },
    );
  }

  void getRandomBooksFromApi() {
    this._randomBooks.clear();
    BookApi.getRandomBook().then((response) {
      setState(() {
        Iterable books = jsonDecode(response.body);
        this._randomBooks = books.map((book) => Book.fromJson(book)).toList();
        // debugPrint(_randomBooks[1].book_name); // çalışıyor
      });
    });
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

  _randomBookClicked(String bookId) {
    //debugPrint(bookId + " li kitaba tıklandı");
    // kitaba tıklandığında id değerini route'a gönderelim
    Navigator.pushNamed(context, "/bookDetail/$bookId");
  }
}

