import 'package:flutter/material.dart';
import 'package:hotel/common/constant.dart';
import 'package:hotel/entity/hotelview.dart';
import 'package:hotel/entity/roomview.dart';
import 'package:hotel/ui/page/room/room_order_page.dart';

class RoomItem extends StatelessWidget {

  RoomView roomView;
  HotelView hotelView;
//  List<DateTime> datelist;
  int room_count;
  RoomItem({
    @required
    this.roomView,
    this.hotelView,
    this.room_count
  });

  @override
  Widget build(BuildContext context) {


    final _media = MediaQuery.of(context).size;
    // TODO: implement build
    return GestureDetector(
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10,top: 20,bottom: 20),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,image: NetworkImage('http://media.china-sss.com/travelguide/pic/shanghai_shanghaihuajingbinguan_gaojibiaozhunfang.jpg')
                    ),
                    borderRadius: BorderRadius.circular(5.0)
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        roomView.room_name??"",
                        style: TextStyle(
                            fontFamily: fontname,
                            fontSize: _media.width / 20,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('不含早 28m 大窗 有窗',
                        style: TextStyle(
                            fontSize: _media.width / 28,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('预定后15分钟可免费取消',
                        style: TextStyle(
                            fontSize: _media.width / 28,
                            color: Colors.teal
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "￥" + roomView.room_price.toString()??"",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.red
                          ),
                        )
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                    return RoomOrderPage(roomView: roomView,hotelView: hotelView);
                  }));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15,top: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 30,
                          width: _media.width * 0.15,
                          decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.deepOrangeAccent,
                                    Colors.redAccent,
                                  ],
                                  begin: const FractionalOffset(0.2, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp
                              ),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0))
                          ),
                          child: Center(
                            child:Text(
                              '预定',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _media.width / 24,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                      ),
                      Container(
                        height: 20,
                        width: _media.width * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.redAccent,
                            ),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0),bottomRight: Radius.circular(5.0))
                        ),
                        child: Center(
                            child:Text(
                              '在线付',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                        ),
                      ),
                      Container(
                        child: Text(
                          roomView.room_count.toString() + "间"??"获取不到房间数",
                          style: TextStyle(
                              color: Colors.red
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}