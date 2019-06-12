import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel/common/api.dart';
import 'package:hotel/common/constant.dart';
import 'package:hotel/entity/orderview.dart';
import 'package:hotel/entity/roomview.dart';
import 'package:hotel/http/service/NetService.dart';
import 'package:hotel/route/routes.dart';
import 'package:hotel/ui/widget/MyDivider.dart';
import 'package:hotel/ui/widget/progress/progressdialog.dart';

class PayPage extends StatefulWidget {

  int room_id;
  RoomView roomView;
  String orderid;
  PayPage({
    @required
    this.room_id,
    this.roomView,
    this.orderid
  });
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {

  bool _loading = false;
  bool check = false;
  Timer _timer;
  int _countdownTime = 0;

  List<OrderView> order_list = [];

  @override
  void initState() {
    // TODO: implement initState
    _startTimer();
    _countdownTime = counttime;
    super.initState();
  }

  @override
  void dispose() {

    if (_timer != null) {
      counttime = _countdownTime;
      _timer.cancel();
    }
    print("dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _medal = MediaQuery.of(context).size;
    // TODO: implement build
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
                Navigator.pop(context);
              }
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () =>{
              },
              child: Container(
                padding: EdgeInsets.only(right: _medal.width/2 - 40),
                alignment: Alignment.center,
                child: Text(
                  '支付订单',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
              ),
            )
          ],
        ),
        body: ProgressDialog(
          loading: _loading,
          child:_mainbody(),
        )

    );

  }

  _mainbody(){

    final _media = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              child: Text(
                '支付剩余时间: ' + _countdownTime.toString(),
                style: TextStyle(

                    color: Colors.grey
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                widget.roomView.room_price.toString()??"",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            Container(
              child: Text(
                widget.roomView.room_name,
                style: TextStyle(
                    fontFamily: 'jindian',
                    color: Colors.grey
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            MyDivider(height: 10,width: 0.5),
            Container(
              child: new CheckboxListTile(
                secondary: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.greenAccent,
                ),
                title: const Text(
                  '微信支付',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
                value: this.check,
                onChanged: (bool value) {
                  setState(() {
                    this.check = !this.check;
                  });
                },
              ),
            ),
            MyDivider(height: 10,width: 0.5,),
          ],
        ),
        _mainbutton(_media),

      ],
    );
  }

  _mainbutton(_media){
    return Container(
      color: Colors.white,
      width: _media.width,
      margin: EdgeInsets.only(top: _media.height - 160),
      child: Column(
        children: <Widget>[
          MyDivider(height: 0,width: 0.5,),
          Container(
              height:50,
              width: _media.width * 0.85,
              margin: EdgeInsets.only(top: 15),
              decoration: new BoxDecoration(
                //渐变色
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  gradient: new LinearGradient(
                      colors: [
                        Colors.deepOrangeAccent,
                        Colors.redAccent.withAlpha(220),
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
                    "确认支付",
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 23.0
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), //圆角大小
                onPressed: () {
                  setState(() {
                    _loading = true;
                  });
                  NetService.post( COMMIT_ORDER_URL + widget.orderid + "/" + widget.room_id.toString(), (response){
                    print(response);
                    setState(() {
                      _loading = false;
                    });
//                    dispose();

                    Navigator.of(context).popAndPushNamed('${Routes.successpage}');
                  },errorCallBack: (errorMsg){
                    print(errorMsg);
                    setState(() {
                      _loading = false;
                    });
                    Fluttertoast.showToast(
                        msg: "提交订单失败",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white70,
                        fontSize: 16.0
                    );
                  },);
                },
              )
          )
        ],
      ) ,
    );
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    _countdownTime = 60;
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(
        Duration(seconds: 1),
            (timer) {
              setState(() {
                if (_countdownTime < 1) {
                  _timer.cancel();
                } else {
                  _countdownTime = _countdownTime - 1;
                  print(_countdownTime);
                }
              });
        });
  }

}