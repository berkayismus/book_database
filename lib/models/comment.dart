class Comment{
  String comment_id;
  String user_id;
  String book_id;
  String comment_detail;
  int comment_status;
  String comment_created_date;

  Comment(this.comment_id,this.user_id,this.book_id,this.comment_detail,this.comment_status,this.comment_created_date);

  Comment.fromJson(Map json){
    comment_id = json["comment_id"];
    user_id = json["user_id"];
    book_id = json["book_id"];
    comment_detail = json["comment_detail"];
    comment_status = int.tryParse(json["comment_status"]);
    comment_created_date = json["comment_created_date"];
  }


}