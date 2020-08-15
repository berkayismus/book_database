import 'package:book_database/screen/category_detail_screen.dart';
import 'package:book_database/screen/categoy_add_screen.dart';
import 'package:book_database/screen/categoy_update_screen.dart';
import 'package:book_database/screen/dashboard_screen.dart';
import 'package:book_database/screen/main_screen.dart';
import 'package:book_database/screen/register_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      title: "Book Database",
      initialRoute: "/",
      routes: {
        "/" : (context) => MainScreen(),
        "/dashboard" : (context) => DashBoardScreen(),
        "/register" : (context) => RegisterScreen(),
        "/categoryAdd" : (context) => CategoryAddScreen(),
        "/categoryUpdate" : (context) => CategoryUpdateScreen(),
      },
      onGenerateRoute: (RouteSettings settings){
        List<String> pathElemanlari = settings.name.split("/"); //  / categoryDetail / 1
        if(pathElemanlari[1]=='categoryDetail'){
          return MaterialPageRoute(builder: (context)=> CategoryDetailScreen(int.parse(pathElemanlari[2])));
        }
        else{
          return null;
        }
      },
    );
  }
}

