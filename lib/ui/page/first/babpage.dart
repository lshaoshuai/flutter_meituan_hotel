import 'package:flutter/material.dart';
import 'package:hotel/ui/widget/bottom_pop/timebottompop.dart';

import '../../widget/MyDivider.dart';
import '../../widget/bottom_pop/bottompop.dart';
import '../../widget/MyDivider.dart';

class BabPage extends StatefulWidget {
  _BabPageState createState() => _BabPageState();
}

class _BabPageState extends State<BabPage> {
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
            onTap: (){
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
                    //showModalBottomSheet默认点击子widget收起，加一个GestureDetector并设置onTap为false阻断点击事件
                    return GestureDetector(
                      onTap: () => false,
                      child: TimeBottomPop(),
                    );
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
                        Container(
                          alignment: Alignment.centerLeft,
                          width: _media.width * 0.85 * 0.3,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text('今天入住',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.red
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 10,top: 10),
                              ),
                              Container(
                                child: Text(
                                  '5月8日 ',
                                  style:TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                padding: EdgeInsets.only(left:20,top: 3),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width:_media.width * 0.85 * 0.3,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text('明天入住',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.red
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 10,top: 10),
                              ),
                              Container(
                                child:Text(
                                  '5月9日',
                                  style:TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 20,top: 3),
                              ),

                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '共'+'1'+'晚',
                                style: TextStyle(color: Colors.black,fontSize: 11),
                              ),
                            )
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
        InkWell(
            onTap: (){
              setState(() {
                print(1);
              });
            },
            child: Container(
              height: 65,
              child:Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 400 / 30.0,top: 20),
                          width: _media.width * 0.85,
                          child:Text(
                            '搜索酒店/地名/关键字',
                            style:TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          )
                      )
                    ],
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
                    return GestureDetector(
                      onTap: () => false,
                      child: BottomPop(),
                    );
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
                  Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 400 / 30.0,top: 20),
                          width: _media.width * 0.85,
                          child:Text(
                            '设置我喜欢的星级/价格',
                            style:TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          )
                      )
                    ],
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
            child: new FlatButton(
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