import 'package:book_database/widgets/book/book_update_widgets.dart';
import "package:flutter/material.dart";

class BookUpdateScreen extends StatefulWidget {
  @override
  _BookUpdateScreenState createState() => _BookUpdateScreenState();
}

class _BookUpdateScreenState extends State<BookUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kitap Güncelleme Sayfası"),
      ),
      body: BookUpdateWidgets(),
    );
  }
}
