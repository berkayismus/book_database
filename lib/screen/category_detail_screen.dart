import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatefulWidget {
  int categoryIndex;
  CategoryDetailScreen(this.categoryIndex);

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState(categoryIndex);
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {

  // dashboard ekranında kategorilere tıklandığında bu sayfaya constructor vasıtasıyla bir index değeri gelecek
  // bu categoryIndex değeri ile tıklanan kategorinin ID'sini alabileceğiz
  int categoryIndex;
  _CategoryDetailScreenState(this.categoryIndex);

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
      child: Column(
        children: <Widget>[
          buildFirstRow(),
        ],
      ),
    );
  }

  buildFirstRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 5,bottom: 5),
      child: Row(
        children: <Widget>[
          Text("Kategori ID : $categoryIndex"),
        ],
      ),
    );
  }
}

