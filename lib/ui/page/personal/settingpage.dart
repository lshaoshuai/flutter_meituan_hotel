import 'package:flutter/material.dart';
import 'package:hotel/common/constant.dart';
import 'package:hotel/route/routes.dart';
import 'package:hotel/ui/widget/MyDivider.dart';
import 'package:hotel/ui/widget/progress/progressdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SettingPage extends StatefulWidget {

  bool islogin = false;
  SettingPage({@required this.islogin = false});
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  ProgressDialog(
        loading: _loading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon:Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black
              ),
            ),
            title: Text(
              '设置',
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          ),
          body: _mainpage(),
        )
    );
  }
  Future deleteStorageString(key) async {
    print("delete");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }

  _mainpage(){
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              settingWidget("个人信息",null,(){}),
              MyDivider(width: 0.5,),
              settingWidget("换绑手机",null,(){}),
              MyDivider(width: 0.5),
              settingWidget("社交账号绑定","绑定/解绑",(){}),
              MyDivider(width: 0.5),
              settingWidget("设置密码","修改",(){}),
              MyDivider(width: 0.5),
              settingWidget("支付设置",null,(){}),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              settingWidget("安全中心",null,(){
                Navigator.of(context).pushNamed('${Routes.ippage}');
              }),
              MyDivider(width: 0.5),
              settingWidget("通用",null,(){}),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          color: Colors.white,
          child: settingWidget("关于Hotel",null,(){}),
        ),
        Container(
            height:80,
            width: 480,
            padding: EdgeInsets.only(left:10.0, right:10.0,top: 30),
            child: new RaisedButton(
              color: Colors.white,
              child: new Padding(
                padding: EdgeInsets.all(8.0),
                child: new Text(
                  "退出当前账号",
                  style: new TextStyle(
                      fontFamily: 'HanaleiFill', color: Colors.black, fontSize: 16.0),
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), //圆角大小
              onPressed: () {
                setState(() {
                  _loading = true;
                });
                print('注销');
                deleteStorageString(TOKEN_KEY);
                deleteStorageString(USER_NAME);
                setState(() {
                  _loading = !_loading;
                });
                Navigator.of(context).pushNamedAndRemoveUntil('${Routes.mainpage}', (Route<dynamic> route) => false);
              },
            )
        )
      ],
    );
  }

  settingWidget(String keytitle,String extendtext,Function Action){
    final _media = MediaQuery.of(context).size;
    return InkWell(
      onTap: Action,
      child: Row(
        children: <Widget>[
          Container(
              width: _media.width * 0.85,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      keytitle,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black),
                    ),
                    padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                  ),
                  Expanded(
                      child: Container(
                        child: Text(
                          extendtext??"",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey),
                        ),
                        padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                        alignment: Alignment.centerRight,
                      )
                  ),
                ],
              )
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
    );
  }

}
