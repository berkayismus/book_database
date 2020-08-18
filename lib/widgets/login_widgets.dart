import 'package:book_database/data/api/user_api.dart';
import 'package:book_database/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginWidgets extends StatefulWidget {
  @override
  _LoginWidgetsState createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {

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

  // SP ile giriş kontrolü için sayaç tanımlama
  int _counter = 0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userNameController = TextEditingController();
    _userPasswordController = TextEditingController();
    // başlangıçta giriş sayacının bilgisini getirme - daha önce giriş yapıldıysa _counter>0 olacak
    _loadCounter();

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
        // daha önceden giriş yapılmadıysa giriş sayacını 1 arttıralım
        if(_counter==0){
          _incrementCounter();
        }
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
      message,style: _customTextStyle(),
    );
  }

  buildCountNumberMessage(){
    return Text(
      _counter.toString()
    );
  }



  // giriş sayacını getiren fonk.
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // varsa sp değeri countera onu ata, yoksa sıfır ata
      _counter = (prefs.getInt('counter') ?? 0);
      // en az 1 defa giriş yapıldıysa dashboard sayfasına yönlendirelim
      if(_counter>0){
        Navigator.pop(context);
        Navigator.pushNamed(context, "/dashboard");
      }
    });
  }

  // giriş butonuna basıldığında _counter değerini 1 arttıran fonksiyon
  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
    });
  }



  // giriş sayacını silmek için kullanılabilir, örneğin logout işleminde
  Future _spRemove() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('counter');
    });
  }

  _customTextStyle() {
    return TextStyle(
      color: Colors.pink,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }
}
