import 'package:flutter/material.dart';
import 'package:hotel/route/routes.dart';

class SuccessPage extends StatefulWidget {

  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final _media = MediaQuery.of(context).size;
    return _mainpage(_media);
  }

  _mainpage(_media){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: (){
              dispose();
              Navigator.pop(context);
            }
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: _media.height * 0.1),
            child: Text(
              "支付成功",
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 50
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.greenAccent,
                size: 200,
              )
          ),
          _finishbutton(_media)
        ],
      ),
    );
  }

  _finishbutton(_media){
    return Container(
        height:50,
        width: _media.width * 0.85,
        margin: EdgeInsets.only(top: 50),
        decoration: new BoxDecoration(
          //渐变色
            borderRadius: BorderRadius.all(Radius.circular(3)),
            gradient: new LinearGradient(
                colors: [
                  Colors.greenAccent,
                  Colors.greenAccent.withAlpha(200),
                ],
                begin: const FractionalOffset(0.2, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
            )
        ),
        child: new FlatButton(
          child: new Padding(
            padding: EdgeInsets.all(8.0),
            child: new Text(
              "完成",
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 23.0
              ),
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), //圆角大小
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('${Routes.mainpage}', (Route<dynamic> route) => false);
          },
        )
    );
  }

}