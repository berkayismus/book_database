import 'file:///C:/Users/Berkayismus/AndroidStudioProjects/book_database/lib/widgets/dashboard/dashboard_categories_widgets.dart';
import 'file:///C:/Users/Berkayismus/AndroidStudioProjects/book_database/lib/widgets/dashboard/dashboard_main_widgets.dart';
import 'package:book_database/widgets/dashboard/dashboard_profile_widgets.dart';
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
        title: Text("DashBoard Ekranı"),
        actions: <Widget>[
          choosenIndex == 1 ?  _buildCategoryIconButton1() : Container(),
          choosenIndex == 1 ? _buildCategoryIconButton2() : Container(),
          choosenIndex == 1 ? _buildCategoryIconButton3() : Container(),
          choosenIndex == 2 ? _buildBookIconButton1() : Container(),
          choosenIndex == 2 ? _buildBookIconButton2() : Container(),
        ],
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

  void _goToDeleteCategory() {

  }

  _buildCategoryIconButton1() {
    return IconButton(iconSize: 24,onPressed: _goToAddCategory,icon: Icon(Icons.add),);
  }

  _buildCategoryIconButton2() {
    return IconButton(iconSize: 24,onPressed: _goToUpdateCategory,icon: Icon(Icons.update),);
  }

  _buildCategoryIconButton3() {
    return IconButton(iconSize: 24,onPressed: _userLogout,icon: Icon(Icons.power),);
  }

  _buildBookIconButton1() {
    return IconButton(iconSize: 24,onPressed: _goToAddBook,icon: Icon(Icons.add),);
  }

  _buildBookIconButton2(){
    return IconButton(iconSize: 24, onPressed: _goToUpdateBook,icon: Icon(Icons.update),);
  }

  void _goToAddBook() {
    // tıklayınca kitap eklemeye götürecek fonksiyon
    debugPrint("Kitap ekleye basıldı");
  }

  void _goToUpdateBook() {
    // tıklayınca kitap güncellemeye götürecek fonksiyon
    debugPrint("Kitap güncelleye basıldı");

  }
}
