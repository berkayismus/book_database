import 'package:book_database/widgets/main_widgets.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String _haveStarted3Times = '';

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book DB Ana Sayfa"),
      ),

      body: MainWidgets(),
    );
  }
}
