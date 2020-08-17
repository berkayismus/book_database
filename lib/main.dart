import 'file:///C:/Users/Berkayismus/AndroidStudioProjects/book_database/lib/screen/category/category_detail_screen.dart';
import 'file:///C:/Users/Berkayismus/AndroidStudioProjects/book_database/lib/screen/category/categoy_add_screen.dart';
import 'package:book_database/screen/book/book_add_screen.dart';
import 'package:book_database/screen/book/book_update_screen.dart';
import 'package:book_database/screen/category/categoy_update_screen.dart';
import 'package:book_database/screen/dashboard_screen.dart';
import 'package:book_database/screen/login_screen.dart';
import 'package:book_database/screen/register_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      title: "Book Database",
      initialRoute: "/",
      routes: {
        "/" : (context) => LoginScreen(),
        "/dashboard" : (context) => DashBoardScreen(),
        "/register" : (context) => RegisterScreen(),
        "/categoryAdd" : (context) => CategoryAddScreen(),
        "/categoryUpdate" : (context) => CategoryUpdateScreen(),
        "/bookAdd" : (context) => BookAddScreen(),
        "/bookUpdate" : (context) => BookUpdateScreen(),
      },
      onGenerateRoute: (RouteSettings settings){
        List<String> pathElemanlari = settings.name.split("/"); //  / categoryDetail / 1
        if(pathElemanlari[1]=='categoryDetail'){
          return MaterialPageRoute(builder: (context)=> CategoryDetailScreen(pathElemanlari[2]));
        }
        else{
          return null;
        }
      },
    );
  }
}

