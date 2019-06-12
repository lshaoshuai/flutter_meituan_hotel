import 'package:flutter/material.dart';
import '../MyDivider.dart';
import '../calendar/calendar.dart';

class TimeBottomPop extends StatefulWidget{

  ValueChanged onChange;
  TimeBottomPop({
    this.onChange,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TimeBottomPopState();
  }
}

class _TimeBottomPopState extends State<TimeBottomPop>{


  int ontaptime = 0;
  bool isontap = false;
  List<DateTime> datelist = [];
  ScrollController _scrollcontroller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollcontroller.addListener(() {
      if ( _scrollcontroller.offset % 360 < 20 ) {
        setState(() {
          ontaptime = (_scrollcontroller.offset / 360).floor();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery
        .of(context)
        .size;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle:true,
          title: Container(
            child: Text('选择日期',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black
              ),
            ),
          ),
          backgroundColor: Colors.white70,
          leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: ()=>Navigator.pop(context),
          ),
          bottom: PreferredSize(
              child:Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: <Widget>[
                        weekkey("日",_media,Colors.red),
                        weekkey("一",_media,Colors.black),
                        weekkey("二",_media,Colors.black),
                        weekkey("三",_media,Colors.black),
                        weekkey("四",_media,Colors.black),
                        weekkey("五",_media,Colors.black),
                        weekkey("六",_media,Colors.red),
                      ],
                    ),
                  ),
                  MyDivider(height: 3, width: 0.5,),
                  Container(
                    width: _media.width,
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                        DateTime.now().year.toString() + "年" + (DateTime.now().month + ontaptime).toString() + "月"
                    ),
                  )
                ],
              ) ,
              preferredSize: Size.fromHeight(50)),

        ),
        body: Stack(
          children: <Widget>[
            _mainbody(),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: _media.height * 0.40),
              child: Column(
                children: <Widget>[
                  MyDivider(height: 0,width: 0.5,),
                  _mainbutton(_media)
                ],
              ),
            )
          ],
        )
    );
  }

  _mainbutton(_media){
    return Container(
        height:50,
        width: _media.width * 0.8,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left:10.0, right:10.0),
        child: new RaisedButton(
          color: Colors.red,
          child: new Padding(
            padding: EdgeInsets.all(8.0),
            child: new Text(
              "选择日期",
              style: new TextStyle(
                  fontFamily: 'HanaleiFill', color: Colors.white, fontSize: 25.0),
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), //圆角大小
          onPressed: () {
            Navigator.pop(context,datelist.isEmpty? [DateTime.now(),DateTime.now().add(Duration(days: 1))]:datelist);
          },
        )
    );
  }

  _mainbody(){
    return Container(
      height: 400,
      child: CustomScrollView(
        controller: _scrollcontroller,
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context,int index){
                    return Calendar(
                          initTime: DateTime.now(),
                          firstTime: DateTime.now(),
                          endTime: DateTime.now(),
                          onChange: (m){
                            //print(m);
                            datelist.clear();
                            if(m[0].isBefore(m[1])){
                              print(1);
                              datelist.add(m[0]);
                              datelist.add(m[1]);
                            }
                          }
                      );
                  },
                  childCount: 1
              )
          ),
        ],
      ),
    );
  }

  weekkey(String week,var _media,Color color){
    return   Container(
      alignment: Alignment.center,
      width: _media.width / 7,
      child: Text(
        week,
        style: TextStyle(
            color: color,
            fontSize: 15
        ),
      ),
    );
  }
}
