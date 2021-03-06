import 'dart:convert';

import 'package:book_database/data/api/book_api.dart';
import 'package:book_database/data/api/comment_api.dart';
import 'package:book_database/data/api/user_api.dart';
import 'package:book_database/models/book.dart';
import 'package:book_database/models/comment.dart';
import 'package:book_database/models/user.dart';
import 'package:book_database/screen/category/category_detail_screen.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatefulWidget {

  // kitaba tıklandığında bu class'a tıklanan kitabın ID'si gelecek
  String _bookId ="";
  BookDetailScreen(this._bookId);

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState(_bookId);
}

class _BookDetailScreenState extends State<BookDetailScreen> {

  String _bookId ="";
  _BookDetailScreenState(this._bookId);

  // book
  Book _book;
  bool _bookVisibleState = false;

  // widget states
  bool _bookDetailState = true;

  // lists
  List<Comment> _commentList = List<Comment>();
  // yorumlar için
  List<User> _userList = List<User>();
  bool _userVisibleState = false;

  // controllers
  TextEditingController _commentDetailController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookFromApi();
    getCommentsFromApi();
    _commentDetailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentDetailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildCustomScroolView(),
    );
  }

  void getBookFromApi() {
    BookApi.getBookByBookId(_bookId).then((response){
      setState(() {
        var jsonData = jsonDecode(response.body);
        _book = Book.fromJson(jsonData);
        _bookVisibleState = true;
      });
    });
  }

  buildCustomScroolView() {
    return CustomScrollView(
      slivers: [
        buildSliverAppBar(),
        _bookDetailState == true ? buildBookDetail() : buildBookComments(),
      ],
    );
  }

  buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 150,
      pinned: true,
      backgroundColor: Colors.pink,
      title: Text(_bookVisibleState == true ? _book.book_name : ""),
      actions: [
        IconButton(icon: Icon(Icons.description),color: Colors.white,onPressed: _showDetailClicked,),
        IconButton(icon: Icon(Icons.message),color: Colors.white,onPressed: _showCommentsClicked,),
        IconButton(icon: Icon(Icons.grade),color: Colors.white,onPressed: _doCommentClicked,),
      ],
    );
  }

  buildBookDetail() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.teal.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_bookVisibleState == true ? _book.book_detail + "\n\n\n Yazar: " + _book.book_author + "\n Sayfa Sayısı: " + _book.book_page_number.toString() + "\n Yayınevi: " + _book.book_publisher : "",style: _customTextStyle(),),
        ),
      ),
    );
  }

  buildBookComments(){
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        _buildCommentItem,childCount: _commentList.length
      ),
    );
  }

  void _showCommentsClicked() {
    getCommentsFromApi();
    setState(() {
      _bookDetailState = false;
    });

  }

  void _doCommentClicked() {
    debugPrint("Yorum yapa tıklandı");
    // alertdialog açılsın
    _commentDialog();
  }

  Future<void> _commentDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yorum yapın'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_bookVisibleState == true ? "${_book.book_name} adlı kitaba yorum yapıyorsunuz" : ""),
                SizedBox(height: 25,),
                TextField(
                  controller: _commentDetailController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Yorumunuz buraya gelecek",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yorum yap'),
              onPressed: () {
                _doComment();
              },
            ),
            FlatButton(
              child: Text("Kapat"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDetailClicked() {
    setState(() {
      _bookDetailState = true;
    });
  }

  Widget _buildCommentItem(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text("${_commentList[index].comment_detail}",style: _customCommentTextStyle(),),
        subtitle: Text("${_commentList[index].comment_created_date}"),
        trailing: Text(_userVisibleState == true ? _userList[index].user_name : ""),
      ),
    );
  }

  _customTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  _customCommentTextStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  void getCommentsFromApi() {
    CommentApi.getCommentsByBookId(_bookId).then((response) {
      setState(() {
        Iterable commentList = jsonDecode(response.body);
        this._commentList = commentList.map((comment) => Comment.fromJson(comment)).toList();
        getUserFromApi(_commentList);
      });
    });
  }

  void getUserFromApi(List<Comment> commentList) {
    for(var comment in commentList){
      UserApi.getUserByUserId(comment.user_id).then((response) {
        var userJson = jsonDecode(response.body);
        var newUser = User.fromJson(userJson);
        _userList.add(newUser);
      });
    }
    setState(() {
      _userVisibleState = true;
    });
  }

  void _doComment() {
    // yorum yapma api 'ını çalıştıracak fonksiyon
    CommentApi.doComment("1", _book.book_id, _commentDetailController.text)
        .then((response) {
          Navigator.pop(context);
          setState(() {
            if(_userVisibleState==true){
              _bookDetailState = true;
            }
          });
        });
  }





}
