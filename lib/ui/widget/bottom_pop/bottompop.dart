import 'package:flutter/material.dart';
import '../../widget/MyDivider.dart';

class BottomPop extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomPopState();
  }
}

class _BottomPopState extends State<BottomPop>{

  double slidervalue = 0.0;
  @override
  Widget build(BuildContext context) {


    final _media = MediaQuery
        .of(context)
        .size;

    // TODO: implement build
    return Container(
      height: _media.height * 0.8,
      child: Column(
        children: <Widget>[
          Container(
            child: Text('价格'),
          ),
          Slider(
            value: slidervalue,
            onChanged: (double val) {
              this.setState(() {
                slidervalue = val;
              });
            },
          ),
          Container(
            child: Text('星级'),
          ),
          MyDivider(height: 0),
          Container(
              height:80,
              width: 480,
              padding: EdgeInsets.only(left:10.0, right:10.0,top: 30),
              child: new RaisedButton(
                color: Colors.red,
                child: new Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text(
                    "完成",
                    style: new TextStyle(
                        fontFamily: 'HanaleiFill', color: Colors.white, fontSize: 25.0),
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), //圆角大小
                onPressed: () {
                },
              )
          )
        ],
      ),
    );
  }
}