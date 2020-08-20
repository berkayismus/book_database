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

}