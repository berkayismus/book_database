class Category{
  String category_id;
  String category_name;

  // constructors
  Category.withId(this.category_id,this.category_name);
  Category(this.category_name);

  // json nesnesinden objeye dönüşüm yaptıran constructor
  Category.fromJson(Map json){
    category_id = json["category_id"];
    category_name = json["category_name"];
  }
}