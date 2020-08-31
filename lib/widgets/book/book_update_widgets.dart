import 'dart:convert';

import 'package:book_database/data/api/book_api.dart';
import 'package:book_database/models/book.dart';
import 'package:flutter/material.dart';

class BookUpdateWidgets extends StatefulWidget {
  @override
  _BookUpdateWidgetsState createState() => _BookUpdateWidgetsState();
}

class _BookUpdateWidgetsState extends State<BookUpdateWidgets> {

  // consts
  double fieldSpaceHeight = 5.0;
  double fieldSpaceWidth = 5.0;

  // controllers
  TextEditingController _bookNameController;
  TextEditingController _bookDetailController;
  TextEditingController _bookPageNumberController;
  TextEditingController _bookPublisherController;
  TextEditingController _bookAuthorNameController;

  // messages
  String _message = "";

  // lists
  List<Book> _bookList = List<Book>();
  List<DropdownMenuItem<Book>> _bookItems = List<DropdownMenuItem<Book>>();
  Book _selectedBook;

  // states
  bool _fieldState = false;
  bool _updateButtonState = false;
  bool _buttonsState = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookNameController = TextEditingController();
    _bookDetailController = TextEditingController();
    _bookPublisherController = TextEditingController();
    _bookPageNumberController = TextEditingController();
    _bookAuthorNameController = TextEditingController();
    getBooksFromApi();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bookNameController.dispose();
    _bookDetailController.dispose();
    _bookPublisherController.dispose();
    _bookPageNumberController.dispose();
    _bookAuthorNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          buildBooksField(),
          _fieldState == true ? buildBookNameField() : Container(),
          _fieldState == true ? buildBookDetailField() : Container(),
          _fieldState == true ? bookAuthorNameField() : Container(),
          _fieldState == true ? buildBookPageNumberField() : Container(),
          _fieldState == true ? buildBookPublisherField() : Container(),
          //buildBookTotalScoreField(),
          //buildBookTotalRepField(),
          //buildBookAverageScoreField(),
          _buttonsState == true ? buildButtonsField() : Container(),
          _updateButtonState == true ? buildUpdateButtonField() : Container(),
          buildMessageField(),

        ],
      ),
    );
  }

  buildBookNameField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _bookNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Kitap Adı",
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildBookDetailField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 5,
              controller: _bookDetailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Kitap Açıklaması",
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildBookPageNumberField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: _bookPageNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Sayfa Sayısı",
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildBookPublisherField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: _bookPublisherController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Yayıncı Adı",
              ),
            ),
          ),
        ],
      ),
    );
  }

  bookAuthorNameField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              maxLines: 1,
              controller: _bookAuthorNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Yazar Adı",
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildButtonsField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Text("Güncelle"),
            color: Colors.pink,
            textColor: Colors.white,
            onPressed: _bookUpdateClicked,
          ),
          SizedBox(width: 5,),
          FlatButton(
            child: Text("Sil"),
            color: Colors.pink,
            textColor: Colors.white,
            onPressed: _bookDeleteClicked,
          ),
        ],
      ),
    );
  }

  void _bookUpdateClicked() {
    // kitap güncelleme butonuna basıldığında burası çalışacak
    setState(() {
      _fieldState = true;
      _updateButtonState = true;
      _buttonsState = false;
    });
  }

  void _bookDeleteClicked() {
    debugPrint("Kitap sil'e basıldı");
    BookApi.deleteBook(_selectedBook.book_id).then((response) {
      setState(() {
        var jsonData = jsonDecode(response.body);
        _message = jsonData["message"];
        _bookList.clear();
        _bookItems.clear();
        getBooksFromApi();
      });
    });
  }

  buildBooksField() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
          children: <Widget>[
            Text("Kitaplar",style: _customTextStyle(),),
            SizedBox(width: 20,),
            buildDDMenu(),
          ],
        ),
    );
  }

  buildMessageField() {
    return Text(_message,style: _customTextStyle(),);
  }

  void getBooksFromApi() {
    BookApi.getBooksAll().then((response) {
      setState(() {
        Iterable bookList = jsonDecode(response.body);
        this._bookList = bookList.map((book) => Book.fromJson(book)).toList();
        _selectedBook = _bookList[0];
        getBookWidgets();
        setTextFields();
      });
    });
  }

  List<DropdownMenuItem> getBookWidgets() {
    for(Book book in _bookList){
      _bookItems.add(getBookWidget(book));
    }
    return _bookItems;
  }

  DropdownMenuItem<Book> getBookWidget(Book book) {
    return DropdownMenuItem(
      child: Text(book.book_name),
      value: book,
    );
  }

  _customTextStyle() {
    return TextStyle(
      color: Colors.pink,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  buildDDMenu() {
    return DropdownButton(
      items: _bookItems,
      value: _selectedBook,
      onChanged: (value) => onChangedBook(value),
    );
  }

  onChangedBook(value) {
    setState(() {
      _selectedBook = value;
      _bookNameController.text = _selectedBook.book_name;
      _bookDetailController.text = _selectedBook.book_detail;
      _bookAuthorNameController.text = _selectedBook.book_author;
      _bookPageNumberController.text = _selectedBook.book_page_number.toString();
      _bookPublisherController.text = _selectedBook.book_publisher;
    });
  }

  void setTextFields() {
    _bookNameController.text = _selectedBook.book_name;
    _bookDetailController.text = _selectedBook.book_detail;
    _bookAuthorNameController.text = _selectedBook.book_author;
    _bookPageNumberController.text = _selectedBook.book_page_number.toString();
    _bookPublisherController.text = _selectedBook.book_publisher;
  }

  buildUpdateButtonField() {
    return Padding(
      padding: EdgeInsets.only(top: fieldSpaceHeight,bottom: fieldSpaceHeight),
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Text("Güncelle"),
            color: Colors.green,
            textColor: Colors.white,
            onPressed: _bookUpdate,
          ),
          SizedBox(width: fieldSpaceWidth,),
          FlatButton(
            child: Text("Temizle"),
            color: Colors.pink,
            textColor: Colors.white,
            onPressed: _fieldsResetClicked,
          ),
        ],
      ),
    );
  }



  void _fieldsResetClicked() {
     // temizle butonuna basıldığında burası çalışacak
      setState(() {
        _bookNameController.text = "";
        _bookDetailController.text = "";
        _bookPageNumberController.text = "";
        _bookPublisherController.text = "";
        _bookAuthorNameController.text = "";
        _message = "";
      });
  }

  void _bookUpdate() {
    // kitap güncelleme butonuna basıldığında burası çalışacak
    String bookName = _bookNameController.text;
    String bookDetail = _bookDetailController.text;
    int bookPageNumber = int.tryParse(_bookPageNumberController.text);
    String bookPublisher = _bookPublisherController.text;
    int bookStatus = 1;
    double bookTotalScore = 10;
    double bookTotalRep = 2;
    double bookAverageScore = 5;
    String categoryId = _selectedBook.category_id;
    String bookAuthor = _bookAuthorNameController.text;

    Book updatedBook = Book.forUpdate(bookName,bookDetail,bookPageNumber,
        bookPublisher,bookAuthor);

    String bookId = _selectedBook.book_id;

    // api çalıştırılacak
    BookApi.updateBook(updatedBook,bookId).then((response) {
      setState(() {
        var jsonData = jsonDecode(response.body);
        _message = jsonData["message"];
        _bookList.clear();
        _bookItems.clear();
        getBooksFromApi();
      });
    });
  }
}
