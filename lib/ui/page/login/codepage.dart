import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel/common/api.dart';
import 'package:hotel/common/constant.dart';
import 'package:hotel/entity/usertoken.dart';
import 'package:hotel/route/routes.dart';
import 'package:hotel/ui/page/login/verification_code_view.dart';
import 'package:hotel/http/service/NetService.dart';
import 'package:hotel/ui/widget/progress/progressdialog.dart';
import 'package:hotel/utils/storage.dart';


class CodePage extends StatefulWidget {
  String phone_num;
  String verifyCode;
  CodePage({@required this.phone_num,this.verifyCode});
  @override
  _CodePageState createState() => new _CodePageState();
}

class _CodePageState extends State<CodePage> {


  TextEditingController _textEditingController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController.addListener((){
      if(_textEditingController.text.length == 4){
        setState(() {
          _loading = true;
        });
        print(widget.phone_num);
        print(_textEditingController.text);
        print(TOKEN_URL);
        NetService.post(TOKEN_URL, (response){
          print(response);
          UserToken userToken = new UserToken.fromJson(response.data['result']);
          setState(() {
            _loading = !_loading;
          });
          saveStorageString(USER_NAME,userToken.phone_num);
          saveStorageString(TOKEN_KEY,userToken.acesstoken);
          Navigator.of(context).pushNamedAndRemoveUntil('${Routes.mainpage}', (Route<dynamic> route) => false);
        },params: {'phone_num':widget.phone_num,'verifyCode':_textEditingController.text},
            errorCallBack: (errorMsg){
              print(errorMsg);
              setState(() {
                _loading = !_loading;
                _textEditingController.text = "";

              });
              Fluttertoast.showToast(
                  msg: errorMsg,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white70,
                  fontSize: 16.0
              );
            }
        );

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProgressDialog(
        loading: _loading,
        child:Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.greenAccent,
                ),
                onPressed: (){
                  _checkSub(context);
                }
            ),
            actions: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  '帮助',
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 20
                  ),
                ),
              )
            ],
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: _mainbody(),
        )
    );
  }

  _mainbody(){
    final _media = MediaQuery.of(context).size;
    var underLineBorder =  CustomUnderlineInputBorder(
        textLength: 4,
        textSize: 80,
        letterSpace: 20.0,
        borderSide: BorderSide(color: Colors.black87, width: 1.0)
    );

    return Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20,top: 30),
              child: Text(
                '输入验证码',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20,top: 10),
              child: Text(
                '验证码已发送至' + '+86 ' + widget.phone_num,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
              child: TextField(
                //限制输入字数
                inputFormatters: [LengthLimitingTextInputFormatter(4),WhitelistingTextInputFormatter.digitsOnly],
                controller: _textEditingController,
                keyboardType: TextInputType.number,
                cursorWidth: 0.0,
                autofocus: true,
                style: TextStyle(
                    fontSize: 80.0,
                    color: Colors.black87,
                    letterSpacing: 20.0),
                decoration: InputDecoration(
                    enabledBorder: underLineBorder,
                    focusedBorder: underLineBorder),
              ),
            ),
            GestureDetector(
              onTap:(){
                setState(() {
                  _loading = true;
                });
                NetService.post(CODE_URL + widget.phone_num, (response){
                  print(response.data['result']);
                  setState(() {
                    _loading = false;
                  });
                },errorCallBack: (errorMsg){
                  print(errorMsg);
                  setState(() {
                    _loading = false;
                  });
                  Fluttertoast.showToast(
                      msg: "网络请求异常，获取不到验证码",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white70,
                      fontSize: 16.0
                  );
                });
              },
              child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20,top: 50),
                child: Text(
                  '点击重新接受验证码',
                  style: TextStyle(
                    color: Colors.greenAccent,
                  ),
                ),

              ),
            )
          ],
        )
    );
  }

  void _checkSub(BuildContext context) {
    Navigator.pop(context);
  }
}