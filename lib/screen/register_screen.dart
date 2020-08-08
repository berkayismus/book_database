import 'package:book_database/widgets/register_widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Kayıt Sayfası"),
      ),
      body: RegisterWidgets(),
    );
  }
}
