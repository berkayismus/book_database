import 'package:book_database/widgets/category/category_update_widgets.dart';
import 'package:flutter/material.dart';

class CategoryUpdateScreen extends StatefulWidget {
  @override
  _CategoryUpdateScreenState createState() => _CategoryUpdateScreenState();
}

class _CategoryUpdateScreenState extends State<CategoryUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategori Güncelleme Sayfası"),
      ),
      body: CategoryUpdateWidgets(),
    );
  }
}
