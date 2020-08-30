import 'package:http/http.dart' as http;

final String base_url = "http://10.0.3.2";

class CommentApi{

  static Future getCommentsByBookId(String bookId) async {
    var response = await http.get("$base_url/ibdb/comments/?book_id=$bookId");
    if(response.statusCode==200){
      return response;
    } else{
      throw("Yorumları getirirken hata");
    }
  }

  static Future doComment(String user_id,String book_id,String comment_detail) async {
    Map data = {
      "user_id":user_id,
      "book_id":book_id,
      "comment_detail":comment_detail
    };
    var response = await http.post("$base_url/ibdb/comments/add/index.php",body: data);
    if(response.statusCode==200){
      return response;
    } else{
      throw("Yorum yaparken hata");
    }
  }

}