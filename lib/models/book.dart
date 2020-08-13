class Book{
  String book_id;
  String category_id;
  String book_name;
  String book_detail;
  int book_page_number;
  String book_publisher;
  int book_status;
  String book_created_date;
  double book_total_score;
  double book_total_rep;
  double book_average_score;

  Book.fromJson(Map json){
    this.book_id = json["book_id"];
    this.category_id = json["category_id"];
    this.book_name = json["book_name"];
    this.book_detail = json["book_detail"];
    this.book_page_number = int.tryParse(json["book_page_number"].toString());
    this.book_publisher = json["book_publisher"];
    this.book_status = int.tryParse(json["book_status"]);
    this.book_created_date = json["book_created_date"];
    this.book_total_score = double.tryParse(json["book_total_score"]);
    this.book_total_rep = double.tryParse(json["book_total_rep"]);
    this.book_average_score = double.tryParse(json["book_average_score"]);
  }
}