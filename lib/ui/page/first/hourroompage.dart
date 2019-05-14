import 'package:flutter/material.dart';

import '../../widget/bottom_pop/bottompop.dart';
import '../../widget/MyDivider.dart';
import '../../widget/MyDivider.dart';

class HourroomPage extends StatefulWidget {
  _HourroomPageState createState() => _HourroomPageState();
}

class _HourroomPageState extends State<HourroomPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _mainpage(context);
  }

  _mainpage(context){

    final _media = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        InkWell(
            onTap:  (){
              setState(() {
                print(1);
              });
            },
            child: Container(
              height: 65,
              child:Row(
                children: <Widget>[
                  Container(
                    width: _media.width * 0.85,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text('目的地',style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey),
                          ),
                          padding: EdgeInsets.only(left: 20,top: 10),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child:Text(
                            '哈尔滨',
                            style:TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 20,top: 5),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child:Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Colors.grey),
                      )
                  ),
                ],
              ),
            )
        ),
        MyDivider(height: 0,indent: 400 / 30.0,endindent: 400 / 30.0,),
        InkWell(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context){
                    return BottomPop();
                  }
              );
              setState(() {
                print(1);
              });
            },
            child: Container(
              height: 65,
              child:Row(
                children: <Widget>[
                  Container(
                    width:_media.width * 0.85,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              child: Text('今天入住',style: TextStyle(color: Colors.red),),
                              padding: EdgeInsets.only(left: 10,top: 10),
                            ),
                            Padding(
                              child:Text(
                                '5月8日',
                                style:TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              padding: EdgeInsets.only(left:20,top: 5),
                            )
                          ],
                        ),                  Column(
                          children: <Widget>[
                            Container(
                              child: Text('明天入住',style: TextStyle(color: Colors.red),),
                              padding: EdgeInsets.only(left: 40,top: 10),
                            ),
                            Padding(
                              child:Text(
                                '5月9日',
                                style:TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              padding: EdgeInsets.only(left: 50,top: 5),
                            )
                          ],
                        )
                      ],
                    ) ,
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child:Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Colors.grey),
                      )
                  ),
                ],
              ),
            )
        ),
        MyDivider(height: 0,indent: 400 / 30.0,endindent: 400 / 30.0,),
        Container(
            height:80,
            width: 480,
            padding: EdgeInsets.only(left:10.0, right:10.0,top:30.0),
            child: new RaisedButton(
              color: Colors.red,
              child: new Padding(
                padding: EdgeInsets.all(8.0),
                child: new Text(
                  "查找酒店",
                  style: new TextStyle(
                      fontFamily: 'HanaleiFill', color: Colors.white, fontSize: 25.0),
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              onPressed: () {},
            )
        ),
      ],
    );
  }

}
