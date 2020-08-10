import 'dart:convert';

import 'package:book_database/models/category.dart';
import 'package:http/http.dart' as http;

final String base_url = "http://10.0.3.2";

class CategoryApi{
  
  static Future<List<Category>> getCategoriesAll() async {
    var response = await http.get(base_url+"/ibdb/categories/all.php");

    var categories = List<Category>();

    if(response.statusCode==200){
      var categoriesJson = jsonDecode(response.body);
      for(var categoryJson in categoriesJson){
        categories.add(Category.fromJson(categoryJson));
      }
      return categories;
    }else{
      throw("Kategoriler getirilirken hata");
    }
  }
  
}
