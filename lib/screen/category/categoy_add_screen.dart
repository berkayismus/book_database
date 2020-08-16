import 'package:book_database/widgets/category/category_add_widgets.dart';
import 'package:flutter/material.dart';

class CategoryAddScreen extends StatefulWidget {
  @override
  _CategoryAddScreenState createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategori Ekleme Sayfası"),
      ),
      body: CategoryAddWidgets(),
    );
  }
}
