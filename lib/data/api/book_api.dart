import 'dart:convert';

import 'package:book_database/data/api/user_api.dart';
import 'package:book_database/models/book.dart';
import 'package:http/http.dart' as http;

final String base_url = "http://10.0.3.2";

class BookApi{

    static Future getBooksByCategoryId(String categoryId) async {
      // sadece aktif -> book_status = 1 olan kitapları getirir
      var response = await http.get("$base_url/ibdb/books/all.php?category_id=$categoryId&book_status=1");
      if(response.statusCode==200){
        return response;
      } else{
        throw("Kitaplar getirilirken hata");
      }
    }
  
  }

