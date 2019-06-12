import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel/common/api.dart';
import 'package:hotel/common/constant.dart';
import 'package:hotel/entity/orderview.dart';
import 'package:hotel/http/service/NetService.dart';
import 'package:hotel/ui/widget/progress/progressdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'orderitem.dart';

class OrderPage extends StatefulWidget {

  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  bool _loading = true;

  List<OrderView> order_list = [];

  @override
  void initState() {
    // TODO: implement initState
    getStorageString(USER_NAME);
    super.initState();

  }

  Future getStorageString(key) async {

    setState(() {
      _loading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    gobalUserName = sharedPreferences.get(key);
    NetService.post(ORDER_URL + gobalUserName, (response){
      print(response.data['result']);
      setState(() {
        for(var s in response.data['result']){
          order_list.add(new OrderView.fromJson(s));
        }
        _loading = false;
      });
    },errorCallBack: (errorMsg){
      print(errorMsg);
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
          msg: "网络请求异常，获取不到订单信息",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white70,
          fontSize: 16.0
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final _medal = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          actions: <Widget>[
            GestureDetector(
              onTap: () =>{
              },
              child: Container(
                padding: EdgeInsets.only(right: _medal.width/2 - 40),
                alignment: Alignment.center,
                child: Text('酒店订单',
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
    return ListView.builder(
      itemCount: order_list.length,
      itemBuilder: (BuildContext context,int index){
        return Orderitem(
            orderView: order_list[index],
            room_in_time :DateTime.parse(order_list[index].room_in_time),
            room_out_time: DateTime.parse(order_list[index].room_out_time)
        );
      },
    );
  }
}