import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/application.dart';
import '../../route/routes.dart';
import 'personal/personalpage.dart';
import 'find/findpage.dart';
import 'order/orderpage.dart';
import 'first/firstpage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key) {
    print('new $key');
  }
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{

  static int lastExitTime = 0;
  bool isLogin = true;
  List<Widget> bodylist = List(); //创建一个非固定长度的widget列表
  int _currentindex = 0;

  @override
  void initState() {
    print("initstate");
    super.initState();
    bodylist
      ..add(FirstPage())
      ..add(FindPage())
      ..add(OrderPage())
      ..add(PersonPage());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return WillPopScope(
        onWillPop: _onBackPressed,
        child:Scaffold(
          resizeToAvoidBottomPadding: false,
          body: bodylist[_currentindex],
          bottomNavigationBar: _MainBottomBar(),
        )
    );
  }

  Future<bool> _onBackPressed() async {
    int nowExitTime = DateTime.now().millisecondsSinceEpoch;
    if(nowExitTime - lastExitTime > 2000) {
      lastExitTime = nowExitTime;
      Fluttertoast.showToast(
          msg: "再按一次退出程序",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return await Future.value(false);
    }
    return await Future.value(true);
  }


  ///主页的底部导航栏
  ///
  Widget _MainBottomBar() {

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 20,
      elevation: 1.0,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(Icons.home, color: Colors.black54),
          activeIcon: Icon(Icons.home, color: Colors.redAccent,),
          title: Text(
            '首页',
            style: _currentindex == 0 ? TextStyle(color: Colors.redAccent,): TextStyle(color: Colors.black54),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(Icons.camera, color: Colors.black54),
          activeIcon: Icon(Icons.camera, color: Colors.redAccent,),
          title: Text(
            '发现',
            style: _currentindex == 1 ? TextStyle(color: Colors.redAccent,): TextStyle(color: Colors.black54),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(Icons.assignment, color: Colors.black54),
          activeIcon: Icon(Icons.assignment, color: Colors.redAccent,),
          title: Text(
            '订单',
            style: _currentindex == 2 ? TextStyle(color: Colors.redAccent,): TextStyle(color: Colors.black54),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(Icons.person, color: Colors.black54),
          activeIcon: Icon(Icons.person, color: Colors.redAccent,),
          title: Text(
            '我的',
            style: _currentindex == 3 ? TextStyle(color: Colors.redAccent,
            ): TextStyle(
                color: Colors.black54),
          ),
        ),
      ],
      currentIndex: _currentindex,
      onTap: (int index) {
        setState(() {
          _currentindex = index;
        });
      },
    );
  }

}