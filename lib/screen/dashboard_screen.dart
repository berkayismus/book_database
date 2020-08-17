import 'file:///C:/Users/Berkayismus/AndroidStudioProjects/book_database/lib/widgets/dashboard/dashboard_categories_widgets.dart';
import 'file:///C:/Users/Berkayismus/AndroidStudioProjects/book_database/lib/widgets/dashboard/dashboard_main_widgets.dart';
import 'package:book_database/widgets/dashboard/dashboard_book_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  // bottomNavBar için seçili index
  int choosenIndex = 0;

  // bottomNavBar'a tıklandığında hangi widgetlar gösterileceğini ayarlayalım
  static List<Widget> _widgetOptions = <Widget>[
    DashBoardMainWidgets(),
    DashBoardCategoriesWidgets(),
    DashBoardBookWidgets(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_buildTitleText()),
        actions: _buildIconButton(),
      ),
      body: _widgetOptions.elementAt(choosenIndex),
      bottomNavigationBar: buildBottomNavMenu(),
    );
  }

  BottomNavigationBar buildBottomNavMenu(){
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Anasayfa"),
        ),BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text("Kategoriler"),
        ),BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text("Kitaplar"),
        ),
      ],
      currentIndex: choosenIndex,
      selectedItemColor: Colors.amberAccent,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      choosenIndex = value;
    });
  }

  // giriş sayacını silmek için kullanılabilir, örneğin logout işleminde
  Future _userLogout() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('counter');
      Navigator.pop(context);
      Navigator.pushNamed(context, "/");
    });
  }

  void _goToAddCategory() {
    // kategori ekleme sayfasına götüren fonksiyon
    Navigator.pushNamed(context, "/categoryAdd");
  }

  void _goToUpdateCategory() {
    // kategori güncelleme sayfasına götüren fonksiyon
    Navigator.pushNamed(context, "/categoryUpdate");
  }

  void _goToAddBook() {
    // tıklayınca kitap eklemeye götürecek fonksiyon
    Navigator.pushNamed(context, "/bookAdd");
  }

  void _goToUpdateBook() {
    // tıklayınca kitap güncellemeye götürecek fonksiyon
    Navigator.pushNamed(context, "/bookUpdate");
  }

  String _buildTitleText() {
    if(choosenIndex==0){
      return "Anasayfa";
    } else if(choosenIndex==1){
      return "Kategoriler";
    } else if(choosenIndex==2){
      return "Kitaplar";
    } else{
      return "";
    }
  }

  List<Widget> _buildIconButton(){
    var iconButtonList = new List<Widget>();
    if(choosenIndex==0){
      iconButtonList.clear();
      iconButtonList.add(IconButton(iconSize: 24,onPressed: (){},icon: Icon(Icons.map),));
      return iconButtonList;
    }
    else if(choosenIndex==1){
      iconButtonList.clear();
      iconButtonList.add(IconButton(iconSize: 24,onPressed: _goToAddCategory,icon: Icon(Icons.add),));
      iconButtonList.add(IconButton(iconSize: 24,onPressed: _goToUpdateCategory,icon: Icon(Icons.update),));
      iconButtonList.add(IconButton(iconSize: 24,onPressed: _userLogout,icon: Icon(Icons.power),));
      return iconButtonList;
    } else if(choosenIndex==2){
      iconButtonList.clear();
      iconButtonList.add(IconButton(iconSize: 24,onPressed: _goToAddBook,icon: Icon(Icons.add),));
      iconButtonList.add(IconButton(iconSize: 24, onPressed: _goToUpdateBook,icon: Icon(Icons.update),));
      return iconButtonList;
    } else if(choosenIndex==3) {
      return null;
    }
  }
}
