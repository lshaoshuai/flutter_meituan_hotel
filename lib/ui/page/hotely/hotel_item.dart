import 'package:flutter/material.dart';
import 'package:hotel/config/application.dart';
import 'package:hotel/route/routes.dart';

class HotelItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _itemwidget(context);
  }

  _navigate(BuildContext context, String route) {
    Application.navigateTo(context: context, route: route);
  }

  _itemwidget(context){

    return InkWell(
      onTap: (){
        _navigate(context, '${Routes.hoteldetailpage}');
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/beijing1.png',
                    ), )
              ),
              margin: EdgeInsets.only(left: 10,top: 10),
              height: 150,
              width: 90,
            ),
            Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(bottom: 5,left: 10),
                      child: Text(
                        '七彩假日旅馆(东北林业大学)',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(bottom: 5,left: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '4.4',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 3),
                              child: Text(
                                '好房价干净温度合适',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 13
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 3),
                              child: Text(
                                '5000+消费',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10
                                ),
                              ),
                            )
                            ,
                          ],
                        )
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(bottom: 5,left: 10),
                      child: Text(
                        '秋林果戈里大街附近',
                        style: TextStyle(
                            fontSize: 13
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.amber, width: 0.5),
                                borderRadius: BorderRadius.all(Radius.circular(2.0))
                            ),
                            padding: EdgeInsets.all(1),
                            child: Text(
                              '好滴',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.amber
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.amber, width: 0.5),
                                borderRadius: BorderRadius.all(Radius.circular(2.0))
                            ),
                            padding: EdgeInsets.all(1),
                            child: Text(
                              '好滴',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.amber
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.amber, width: 0.5),
                                borderRadius: BorderRadius.all(Radius.circular(2.0))
                            ),
                            padding: EdgeInsets.all(1),
                            child: Text(
                              '好滴',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.amber
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(bottom: 0,right: 10),
                      child: Text(
                        '\$88',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 23
                        ),
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}