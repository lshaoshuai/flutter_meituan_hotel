import 'package:flutter/material.dart';

import 'orderitem.dart';

class OrderPage extends StatefulWidget {

  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {



  List<String> slist = ['1','2','3'];

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
        body: ListView.builder(
          itemCount: slist.length,
          itemBuilder: (BuildContext context,int index){
            return Orderitem();
          },
        )
    );

  }
}