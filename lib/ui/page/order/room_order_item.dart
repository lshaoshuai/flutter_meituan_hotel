import 'package:flutter/material.dart';
import 'package:hotel/config/application.dart';
import 'package:hotel/route/routes.dart';

class RoomItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                      child: Text('普通大床房',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('不含早 28m 大窗 有窗',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('预定后15分钟可免费取消',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.teal
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text('98',
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
                  Application.navigateTo(context:context,route: '${Routes.roomorderpage}');
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10,top: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 30,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0))
                          ),
                          child: Center(
                            child:Text(
                              '预定',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                      ),
                      Container(
                        height: 20,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.red,
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
                          '剩8间',
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