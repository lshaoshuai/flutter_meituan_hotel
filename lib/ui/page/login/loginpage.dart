import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hotel/config/application.dart';
import 'package:hotel/http/service/NetService.dart';
import 'package:hotel/route/routes.dart';
import 'package:hotel/ui/widget/MyDivider.dart';
import 'package:hotel/common/api.dart';
import 'package:hotel/ui/widget/progress/progressdialog.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

List _loginMethod = [
  {"title": "facebook", "icon": GroovinMaterialIcons.wechat},
  {
    "title": "google",
    "icon": GroovinMaterialIcons.qqchat,
  },
  {
    "title": "twitter",
    "icon": GroovinMaterialIcons.school,
  },
];

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool is_send = false;
  bool _loading = false;

  TextEditingController schoolController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

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
              _checkSub(context);
            }
        ),
        backgroundColor: Colors.white,
      ),
      body: ProgressDialog(
        loading: _loading,
        child: loginbody(context),
      ),
      backgroundColor: Colors.white,
    );
  }

  ///
  /// 主体
  Widget loginbody(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return new Container(
        height: _media.height,
        child: Column(
          children: <Widget>[
            TopLogo(context,_media),
            loginUserEditInput(_media),
            loginButton(context),
            MyDivider(height: _media.height * 0.05, endindent: _media.width*0.1,indent: _media.width*0.1,),
            //ButtonLogo(context),
            buildOtherMethod(context,_media),
          ],
        ));
  }

  ///
  /// 登陆按钮
  ///
  Widget loginButton(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return new Container(
      width: _media.width * 0.6,
      margin: EdgeInsets.only(top: _media.height * 0.1,bottom: _media.height * 0.1),
      child: new FlatButton(
        color: Colors.greenAccent,
        child: new Padding(
          padding: EdgeInsets.all(8.0),
          child: new Text(
            "获取验证码",
            style: new TextStyle(
                fontFamily: 'HanaleiFill',
                color: Colors.white,
                fontSize: 16.0,
            ),
          ),
        ),
        onPressed: () {
          _request(context);

          //_checkSub(context);
        },
      ),
    );
  }


  void _request(BuildContext context){

    print(CODE_URL + mobileController.value.text);
    print(_loading.toString());
    setState(() {
      _loading = true;
    });
    NetService.post(CODE_URL + mobileController.value.text, (response){
//    Map<String,String> data = json.decode(response.data);
//    print(data['code']);
      print(response.data['result']);
      setState(() {
        _loading = false;
      });
      Application.navigateTo(context:context,route: '${Routes.codepage}?phone_num=${mobileController.value.text}&verifyCode=${response.data['result']}');

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

  }

  ///
  /// 用户名输入框
  ///
  Widget loginUserEditInput(Size media) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0,media.height * 0.1, 20.0, 10.0),
      child: new Stack(
        alignment: Alignment(1.0, 1.0),
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(5.0),
                child: new Icon(Icons.perm_identity),
              ),
              new Expanded(
                  child: new TextField(
                    controller: mobileController,
                    decoration: new InputDecoration(
                        hintText: "请输入电话号码",
                    ),
                    onChanged: (value){
                    },
                  )),
            ],
          ),
          new IconButton(
              icon: new Icon(Icons.clear),
              onPressed: () {
                mobileController.clear();
              })
        ],
      ),
    );
  }


  ///
  /// 登陆提交校验
  ///
  void _checkSub(BuildContext context) {
    Navigator.pop(context);
  }

}

//Widget ButtonLogo(BuildContext context) {
//  return Container(
//    margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//    child: TypewriterAnimatedTextKit(
//      onTap: () {
//        print("Tap Event");
//      },
//      text: [
//        "the story of your university",
//        "write down your beautiful memory",
//        "Don't leave any regrets"
//            "face life with a smile"
//      ],
//      textStyle: TextStyle(fontSize: 20.0, fontFamily: "lishu",color: Color.fromRGBO(116, 116, 116, 0.9)),
//    ),
//  );
//}

Widget TopLogo(BuildContext context,Size media) {
  return Container(
    margin: EdgeInsets.only(top: media.height * 0.05,left: 30),
    alignment: Alignment.topLeft,
    child:Text(
      '欢迎登陆妹团',
      style: TextStyle(
        color: Colors.black,
        fontSize: 35.0,
      ),
    ),
  );
}

///
Widget buildOtherMethod(BuildContext context,Size media) {
  return ButtonBar(
    alignment: MainAxisAlignment.center,
    children: _loginMethod
        .map((item) => Builder(
      builder: (context) {
        return IconButton(
            icon: Icon(item['icon'], color: Colors.black),
            onPressed: () {
              //TODO : 第三方登录方法
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text("${item['title']}登录"),
                action: new SnackBarAction(
                  label: "取消",
                  onPressed: () {},
                ),
              ));
            });
      },
    ))
        .toList(),
  );
}




