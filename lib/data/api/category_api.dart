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

  static Future categoryAdd(String categoryName)async {
    var data = {
      "category_name":categoryName
    };
    var response = await http.post(base_url+"/ibdb/categories/add/index.php",body: data);
    if(response.statusCode == 200){
      return response;
    } else{
      throw("Kategori eklerken hata yaşandı");
    }
  }

  static Future categoryUpdate(String categoryId,String categoryName) async {
    var data = {
      "category_id":categoryId,
      "category_name":categoryName
    };
    var response = await http.post(base_url+"/ibdb/categories/update/index.php",body: data);
    if(response.statusCode==200){
      return response;
    } else{
      throw("Kategori güncellenirken hata");
    }
  }

  static Future categoryDelete(String categoryId) async {
    var data = {
      "category_id":categoryId
    };
    var response = await http.post(base_url+"/ibdb/categories/delete/index.php",body: data);
    if(response.statusCode==200){
      return response;
    } else{
      throw("Kategori silinirken hata");
    }
  }
  
}
