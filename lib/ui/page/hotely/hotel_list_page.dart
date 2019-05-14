import 'package:flutter/material.dart';
import 'hotel_item.dart';

class HotelPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HotelState();
  }
}

class _HotelState extends State<HotelPage>{

  List<String> list = ['1','2','3'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: _mainbody(),
    );
  }

  _mainbody(){
    return Container(
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context,int index){
            return HotelItem();
          }
      ),
    );
  }

}