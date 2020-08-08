import 'package:book_database/data/api/user_api.dart';
import 'package:book_database/models/user.dart';
import 'package:flutter/material.dart';

class MainWidgets extends StatefulWidget {
  @override
  _MainWidgetsState createState() => _MainWidgetsState();
}

class _MainWidgetsState extends State<MainWidgets> {

  TextEditingController _userNameController;
  TextEditingController _userPasswordController;

  // consts
  final double textFieldTopSpace = 5.0;
  final double textFieldBotSpace = 5.0;
  final double buttonTopSpace = 5.0;
  final double buttonBotSpace = 5.0;
  Color flatButtonColor = Colors.pink;
  Color flatButtonTextColor = Colors.white;

  // messages
  String message="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userNameController = TextEditingController();
    _userPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          buildFirstRow(),
          buildSecondRow(),
          buildThirdRow(),
          buildFourthRow(),
        ],
      )
    );
  }

  buildFirstRow() {
    return Padding(
      padding: EdgeInsets.only(top: textFieldTopSpace,bottom: textFieldBotSpace),
      child: Row(
        children: <Widget>[
        Expanded(
          child: TextField(
          controller: _userNameController,
          obscureText: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kullanıcı adı',
          ),
          ),
        ),
        ],
      ),
    );
  }

  buildSecondRow() {
    return Padding(
      padding: EdgeInsets.only(top: textFieldTopSpace,bottom: textFieldBotSpace),
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

  buildThirdRow() {
    return Padding(
      padding: EdgeInsets.only(top: buttonTopSpace,bottom: buttonBotSpace),
      child: Row(
        children: <Widget>[
          FlatButton(
            onPressed: _loginButtonClicked,
            child: Text("Giriş yap"),
            color: flatButtonColor,
            textColor: flatButtonTextColor,
          ),
          SizedBox(width: 10.0,),
          FlatButton(
            onPressed: _registerButtonClicked,
            child: Text("Kayıt ol"),
            color: flatButtonColor,
            textColor: flatButtonTextColor,
          ),
        ],
      ),
    );
  }



  void _loginButtonClicked() async {
    //debugPrint("giriş butonuna basıldı");
    var response = await UserApi.userLogin(_userNameController.text, _userPasswordController.text);
    // response map formatında json döndürüyor - response["message"] && response["tf"] gibi
// mesajı yazdıralım
    setState(() {
      message = response["message"];
      if(response["tf"] == true) {
        // yönlendirme yapmak için
       Navigator.pop(context);
       Navigator.pushNamed(context, "/dashboard");
      }
      else{
        // bilgiler yanlışsa yönlendirme yapma
      }
    });
  }

  void _registerButtonClicked() {
    //debugPrint("kayıt butonuna basıldı");
    Navigator.pushNamed(context, "/register");
  }

  buildFourthRow() {
    return Text(
      message
    );
  }
}
