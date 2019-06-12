
import 'package:flutter/material.dart';
import 'package:hotel/common/api.dart';
import 'package:hotel/ui/widget/progress/progressdialog.dart';

class IpPage extends StatefulWidget {

  _IpPageState createState() => _IpPageState();
}

class _IpPageState extends State<IpPage>{

  TextEditingController _textEditingController = new TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 30,
              color: Colors.greenAccent,
            ),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
        backgroundColor: Colors.white,
      ),
      body: ProgressDialog(
        loading: _loading,
        child:  _mainbody(_media),
      ),
      backgroundColor: Colors.white,
    );
  }

  _mainbody(_media){
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(5.0),
                child: new Icon(Icons.trip_origin),
              ),
              new Expanded(
                  child: new TextField(
                    controller: _textEditingController,
                    decoration: new InputDecoration(
                      hintText: "请输入ip地址:" + BASE_URL,
                    ),
                    onChanged: (value){
                    },
                  )
              ),
              new IconButton(
                  icon: new Icon(Icons.clear),
                  onPressed: () {
                    _textEditingController.clear();
                  }
              )
            ],
          ),
        ),
        _finishbutton(_media)
      ],
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
            BASE_URL = "http://" + _textEditingController.text;
            Navigator.pop(context);
          },
        )
    );
  }

}

