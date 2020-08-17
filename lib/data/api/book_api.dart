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
    
    static Future getBooksAll() async {
      // sadece aktif -> book_status = 1 olan kitapları getirir
      var response = await http.get("$base_url/ibdb/books/all.php");
      if(response.statusCode==200){
        return response;
      } else{
        throw("Kitaplar getirilirken hata");
      }
    }

    static Future addBook(Book book) async {
      Map data = {
        "book_name":book.book_name,
        "book_detail":book.book_detail,
        "book_page_number":book.book_page_number.toString(),
        "book_publisher":book.book_publisher,
        "book_status":book.book_status.toString(),
        "book_total_score":book.book_total_score.toString(),
        "book_total_rep":book.book_total_rep.toString(),
        "book_average_score":book.book_average_score.toString(),
        "category_id":book.category_id,
        "book_author":book.book_author
      };
      var response = await http.post(base_url+"/ibdb/books/add/index.php",body: data);
      if(response.statusCode==200){
        return response;
      }else{
        throw("Kitap eklerken hata");
      }
    }

    static Future updateBook(Book book,String book_id) async {
      Map data = {
        "book_id":book_id,
        "book_name":book.book_name,
        "book_detail":book.book_detail,
        "book_page_number":book.book_page_number.toString(),
        "book_publisher":book.book_publisher,
        "book_author":book.book_author
      };
      var response = await http.post("$base_url/ibdb/books/update/index.php",body: data);
      if(response.statusCode==200){
        return response;
      }else{
        throw("Kitap güncellerken hata");
      }
    }
  
  }

