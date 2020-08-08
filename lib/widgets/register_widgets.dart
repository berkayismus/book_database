import 'package:book_database/data/api/user_api.dart';
import 'package:book_database/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterWidgets extends StatefulWidget {
  @override
  _RegisterWidgetsState createState() => _RegisterWidgetsState();
}

class _RegisterWidgetsState extends State<RegisterWidgets> {

  // controllers
  TextEditingController _userNameController;
  TextEditingController _userEmailController;
  TextEditingController _userPasswordController;
  TextEditingController _userPasswordAgainController;

  // consts
  final double filedPaddingSpace = 5.0;
  final Color flatButtonColor = Colors.pink;
  final Color flatButtonTextColor = Colors.white;

  // messages
  String message = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userNameController = TextEditingController();
    _userEmailController = TextEditingController();
    _userPasswordController = TextEditingController();
    _userPasswordAgainController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          buildFirstRow(),
          buildSecondRow(),
          buildThirdRow(),
          buildFourthRow(),
          buildButtons(),
          buildMessage(),
        ],
      ),
    );
  }

  buildFirstRow() {
    return Padding(
      padding: EdgeInsets.only(top:filedPaddingSpace,bottom: filedPaddingSpace),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _userNameController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Kullanıcı Adı',
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildSecondRow() {
    return Padding(
      padding: EdgeInsets.only(top:filedPaddingSpace,bottom: filedPaddingSpace),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _userEmailController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-posta',
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildThirdRow() {
    return Padding(
      padding: EdgeInsets.only(top:filedPaddingSpace,bottom: filedPaddingSpace),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _userPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Parola',
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildFourthRow() {
    return Padding(
      padding: EdgeInsets.only(top:filedPaddingSpace,bottom: filedPaddingSpace),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _userPasswordAgainController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Parola Tekrar',
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildButtons() {
    return Padding(
      padding: EdgeInsets.only(top:filedPaddingSpace,bottom: filedPaddingSpace),
      child: Row(
        children: <Widget>[
          FlatButton(
            color: flatButtonColor,
            textColor: flatButtonTextColor,
            child: Text("Kayıt ol"),
            onPressed: _registerButtonClicked,
          ),
        ],
      ),
    );
  }



  void _registerButtonClicked() async {
    debugPrint("Kayıt butonuna basıldı");
    // girilen iki password eşleşiyor mu
    bool passControl = userPasswordControl();
    if(passControl){
      // kayıt gerçekleştir
      var user = User.forRegister(_userNameController.text,_userEmailController.text,_userPasswordController.text);
      var jsonResponse = await UserApi.userRegister(user);
      setState(() {
        message = jsonResponse["message"];
      });
    } else{
      setState(() {
        message = "Girdiğiniz iki parola eşleşmelidir";
      });
    }
  }

  bool userPasswordControl() {
    if(_userPasswordController.text == _userPasswordAgainController.text){
      return true;
    } else{
      return false;
    }
  }

  buildMessage() {
    return Padding(
      padding: EdgeInsets.only(top: filedPaddingSpace,bottom: filedPaddingSpace),
      child: Row(
        children: <Widget>[
          Text(message),
        ],
      ),
    );
  }
}
