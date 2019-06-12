import 'package:flutter/material.dart';
import 'package:hotel/config/application.dart';
import 'package:hotel/entity/orderview.dart';
import 'package:hotel/route/routes.dart';
import '../../widget/MyDivider.dart';
import 'order_detail_page.dart';

class Orderitem extends StatefulWidget {

  OrderView orderView;
  DateTime room_in_time;
  DateTime room_out_time;
  Orderitem({
    @required
    this.orderView,
    this.room_in_time,
    this.room_out_time
  });

  _OrderitemState createState() => _OrderitemState();
}

class _OrderitemState extends State<Orderitem> {

  @override
  Widget build(BuildContext context) {

    final _media = MediaQuery.of(context).size;
    // TODO: implement build
    return InkWell(
      onTap:(){
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
          return OrderDetailPage(orderView: widget.orderView);
        }));
      },
      child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: _media.width / 15,top: 30,bottom: 15),
                    child: Icon(Icons.four_k),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _media.width / 60,top: 30,bottom: 15),
                    width: _media.width / 1.6,
                    child: Text(
                      widget.orderView.hotel_name??"",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(top: 30,bottom: 10),
                    child: Text(
                      _isPay(widget.orderView.pay_status),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey
                      ),
                    ),

                  )
                ],
              ),
              MyDivider(height: 0,indent: _media.width / 15, endindent: _media.width / 15,),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: _media.width / 15),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/1.jpg',)
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: _media.width / 40,top: 5),
                          child: Text(
                            widget.orderView.room_count.toString() + '间,' + widget.orderView.room_name??"",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: _media.width / 40,top: 5),
                          child: Text(
                            _datekey(widget.room_in_time,widget.room_out_time),
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: _media.width / 40,top: 5),
                          child: Text(
                            '房价: ' + '￥' + widget.orderView.collection_price.toString(),
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                height: widget.orderView.pay_status == -1 ? 35 : 0,
                margin: EdgeInsets.only(right: _media.width / 20,top: 5 ),
                child: widget.orderView.pay_status == -1 ? OutlineButton(
                  highlightedBorderColor: Colors.greenAccent,
                  highlightColor: Colors.white,
                  onPressed: (){
                    Application.navigateTo(context:context,route: '${Routes.loginpage}');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      )
                  ),
                  borderSide: BorderSide(
                      color: Colors.grey
                  ),
                  child: Text(
                    '再次预订',
                    style: TextStyle(
                        color: Colors.grey ,
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ): SizedBox(),
              )
            ],
          )
      ),
    );
  }

  _isPay(int pay){

    if(pay == 1){
      return '已消费';
    }else if(pay == 0){
      return '等待支付';
    }else{
      return '支付超时';
    }

  }

  _datekey(DateTime datetime,DateTime otherdatetime){
    return datetime.month.toString() + "月"+ datetime.day.toString() + "日" + "-" + otherdatetime.month.toString() + "月"+ otherdatetime.day.toString() + "日";
  }

}

