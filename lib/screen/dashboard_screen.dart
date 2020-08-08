import 'package:book_database/widgets/dashboard_widgets.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard Ekranı"),
      ),
      body: DashBoardWidgets(),
    );
  }
}
