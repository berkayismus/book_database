import 'dart:convert';

import 'package:book_database/models/user.dart';
import 'package:http/http.dart' as http;


final String baseUrl = "http://10.0.3.2";

class UserApi{

  static Future userLogin(String user_name,String user_password) async {
    Map data = {
      "user_name" : user_name,
      "user_password" : user_password,
    };
    var response = await http.post(baseUrl+"/ibdb/user/login/index.php", body: data);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else{
      throw("İstek yapılırken hata");
    }
  }

  static Future userRegister(User user) async {
    Map data = {
      "user_name":user.user_name,
      "user_email":user.user_email,
      "user_password":user.user_password
    };
    var response = await http.post(baseUrl+"/ibdb/user/register/index.php",body: data);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else{
      throw("Kayıt olunurken hata");
    }
  }

}