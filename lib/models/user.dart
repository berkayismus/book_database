
class User{

  String user_id;
  String user_name;
  String user_email;
  String user_password;
  int user_status;
  String user_validate_code;

  // constructor
  User(this.user_name,this.user_email,this.user_password,this.user_status,this.user_validate_code);
  User.withId(this.user_id,this.user_name,this.user_email,this.user_password,this.user_status,this.user_validate_code);
  User.forRegister(this.user_name,this.user_email,this.user_password);

  User.fromJson(Map json){
    user_id = json["user_id"];
    user_name = json["user_name"];
    user_email = json["user_email"];
    user_password = json["user_password"];
    user_status = json["user_status"];
    user_validate_code = json["user_validate_code"];
  }


}