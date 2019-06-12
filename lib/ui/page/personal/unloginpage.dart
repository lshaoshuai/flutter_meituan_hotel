import 'package:flutter/material.dart';
import 'package:hotel/config/application.dart';
import 'package:hotel/route/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnloginPage extends StatefulWidget {

  String pagetype = null;

  UnloginPage({@required this.pagetype });

  _UnloginPageState createState() => _UnloginPageState();
}

class _UnloginPageState extends State<UnloginPage> {

  String token;


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return _mainpage();
  }

  String selectpagetype(){
    if(widget.pagetype == null){
      return '登陆后可查看"我的"页面';
    }else{
      return '登陆后可查看"订单"页面';
    }
  }

  _mainpage(){

    final _media = MediaQuery.of(context).size;

    return Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: _media.height * 0.3),
              height: _media.width * 0.4,
              width: _media.width * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/1.jpg')
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                selectpagetype(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 35,
              width: _media.width * 0.2,
              child: OutlineButton(
                highlightedBorderColor: Colors.greenAccent,
                highlightColor: Colors.white,
                onPressed: (){
                  Application.navigateTo(context:context,route: '${Routes.loginpage}');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10)
                  )
                ),
                borderSide: BorderSide(
                  color: Colors.greenAccent
                ),
                child: Text(
                  '登陆',
                  style: TextStyle(
                    color: Colors.greenAccent ,
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          ],
        )
    );

  }

}