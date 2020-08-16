import 'package:book_database/widgets/book/book_add_widgets.dart';
import 'package:flutter/material.dart';

class BookAddScreen extends StatefulWidget {
  @override
  _BookAddScreenState createState() => _BookAddScreenState();
}

class _BookAddScreenState extends State<BookAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kitap Ekleme Sayfası"),
      ),
      body: BookAddWidgets(),
    );
  }
}
