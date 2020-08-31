import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardMainWidgets extends StatefulWidget {
  @override
  _DashBoardMainWidgetsState createState() => _DashBoardMainWidgetsState();
}

class _DashBoardMainWidgetsState extends State<DashBoardMainWidgets> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          buildFirstRow(),
        ],
      ),
    );
  }

  buildFirstRow() {
    return Padding(
      padding: EdgeInsets.only(top: 5,bottom: 5),
      child: Row(
        children: <Widget>[

            Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_getMessageMain(),style: _customTextStyle(),),
              ),
            ),

        ],
      ),
    );
  }

  _customTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 19,
      fontWeight: FontWeight.bold
    );
  }

  String _getMessageMain() {
    String welcomeMessage = "Hoşgeldiniz, bu uygulama Kütüphane'ye kitap eklemenize, var olan kitapları güncellemenize, veya silmenize olanak tanır.Ayrıca, var olan kitaplara yorum yapabilirsiniz."
        + "Başka kullanıcıların yaptığı yorumları görebilirsiniz. Bu sayede bir çok kitap hakkında bilgiye ulaşabilirsiniz."
        + "Hadi aşağıdaki menüden gezintiye çıkalım.";
    int chNumber = welcomeMessage.length;
    // 40 karakter x 7 satır
    String message = welcomeMessage.substring(0,40)
        + "\n" + welcomeMessage.substring(40,80)
        + "\n" + welcomeMessage.substring(80,120)
        + "\n" + welcomeMessage.substring(120,160)
        + "\n" + welcomeMessage.substring(160,200)
        + "\n" + welcomeMessage.substring(200,240)
        + "\n" + welcomeMessage.substring(240,280)
        + "\n" + welcomeMessage.substring(280,welcomeMessage.length);
    return message;
  }


}
