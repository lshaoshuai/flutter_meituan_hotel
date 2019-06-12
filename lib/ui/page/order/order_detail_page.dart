import 'package:flutter/material.dart';
import 'package:hotel/common/constant.dart';
import 'package:hotel/entity/orderview.dart';
import 'package:hotel/ui/page/order/paystatus.dart';
import 'package:hotel/ui/page/room/room_order_item.dart';
import 'package:hotel/ui/widget/bottom_pop/timebottompop.dart';
import 'package:hotel/ui/widget/loading_more/loading_more_list.dart';
import 'package:hotel/ui/widget/shimmer/shimmer.dart';
import 'package:hotel/ui/widget/stack_appbar/order_appbar.dart';
import '../../widget/MyDivider.dart';

class OrderDetailPage extends StatefulWidget{

  OrderView orderView;
  OrderDetailPage({
    @required
    this.orderView
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderDetailPageState();
  }
}

class _OrderDetailPageState extends State<OrderDetailPage>{

  ScrollController _scrollcontroller = ScrollController();
  OrderBarController _orderbarcontroller = new OrderBarController();
  bool _isNeedSetAlpha = false;
  GlobalKey<OrderAppBarState> _mTitleKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: _mainpage(),
        backgroundColor: Colors.white.withAlpha(230)
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(gobalUserName);
    _orderbarcontroller.value.alpha = 0;

    _scrollcontroller.addListener(() {

      if ( _scrollcontroller.offset < 80.0) {
        _isNeedSetAlpha = true;
        _orderbarcontroller.value.alpha = ((_scrollcontroller.offset / 80) * 255).toInt();
        _mTitleKey.currentState.setState(() {});
      } else {
        if (_isNeedSetAlpha) {
          _orderbarcontroller.value.alpha = 255;
          _mTitleKey.currentState.setState(() {});
          _isNeedSetAlpha = false;
        }
      }
    });
  }


  _mainpage(){
    final _media = MediaQuery.of(context).size;

    return  Stack(
        children: <Widget>[
          new Container(
            height: _media.height,
            child: LoadingMoreCustomScrollView(
              showGlowLeading: false,
              controller: _scrollcontroller,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 250,
                            width: _media.width,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 85,left: 10),
                                  child: Text(
                                     _paystatustitle(widget.orderView.pay_status),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 10,left: 10),
                                  child: Text(
                                    _payillustrate(widget.orderView.pay_status),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.white
                                    ),
                                  ),
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
                                          _paybutton(widget.orderView.pay_status),
                                          style: new TextStyle(
                                              fontFamily: fontname,
                                              color: Colors.black,
                                              fontSize: 16.0
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), //圆角大小
                                      onPressed: () {
                                        widget.orderView.pay_status == 0 ? "去支付": "再次预定";
                                      },
                                    )
                                ),
                              ],
                            ),
                            decoration: new BoxDecoration(
                              //渐变色
                                gradient: new LinearGradient(
                                    colors: [
                                      Colors.deepOrangeAccent,
                                      Colors.redAccent,
                                    ],
                                    begin: const FractionalOffset(0.2, 0.0),
                                    end: const FractionalOffset(1.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp
                                )
                            ),
                          ),
                          Container(
                              height: 65,
                              color: Colors.white,
                              margin: EdgeInsets.only(top: 250),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(top: 10,left: 20),
                                        child: Text(
                                          '关注"lshaoshuai"github账号',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          '订单通知,活动优惠不错过',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(top: 10,right: 20),
                                        height: 30,
                                        child:OutlineButton(
                                          highlightedBorderColor: Colors.greenAccent,
                                          highlightColor: Colors.white,
                                          onPressed: (){
//                                    Application.navigateTo(context:context,route: '${Routes.loginpage}');
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)
                                              )
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent
                                          ),
                                          child: Text(
                                            '去关注',
                                            style: TextStyle(
                                                color: Colors.redAccent ,
                                                fontSize: _media.width / 35,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              )
                          ),
                          Container(
                            height: 50,
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 320),
                            padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(top: 10,left: 10,bottom: 10),
                                      child: Text(
                                        '在线支付',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(top: 10,left: 10,bottom: 10),
                                      child: Text(
                                        widget.orderView.collection_price.toString()??"",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.red
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        margin: EdgeInsets.only(top:10, right: 20, bottom: 10),
                                        child: Text(
                                          '费用明细',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.blueAccent
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),

                          ),
                          Container(
                            height: 280,
                            margin: EdgeInsets.only(top: 375),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 10,left: 10),
                                  child: Text(
                                    widget.orderView.hotel_name??"",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: _media.width / 20
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 10,left: 10,bottom: 20),
                                  child: Text(
                                    '秋林果戈里大街附近',
                                    softWrap: true,
                                  ),
                                ),
                                MyDivider(height: 0,width: 0.5, endindent: 20, indent: 20,),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 10,left: 10,bottom: 20),
                                  child: Text(
                                    widget.orderView.room_name??"",
                                    softWrap: true,
                                  ),
                                ),
                                Container(
                                    child: Row(
                                      children: <Widget>[
                                        _orderkey("入住人"),
                                        _ordervalue(widget.orderView.user_id)
                                      ],
                                    )
                                ),
                                Container(
                                    child: Row(
                                      children: <Widget>[
                                        _orderkey("联系手机"),
                                        _ordervalue(widget.orderView.user_id)
                                      ],
                                    )
                                ),
                                Container(
                                    child: Row(
                                      children: <Widget>[
                                        _orderkey("预计到店"),
                                        _ordervalue("姓名")
                                      ],
                                    )
                                ),
                                Container(
                                    child: Row(
                                      children: <Widget>[
                                        _orderkey("入住说明"),
                                        _ordervalue("姓名")
                                      ],
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 660),
                            height: 120,
                            width: _media.width,
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 10,top: 10),
                                  child: Text(
                                    "订单信息",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      _orderkey("订单号"),
                                      _ordervalue(widget.orderView.order_id.toString()??""),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      _orderkey("下单时间"),
                                      _ordervalue(widget.orderView.order_set_time),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          _questionwidget(_media)
                        ],
                      ),
                    ],
                  ),
                ),
//                LoadingMoreSliverList(
//                    SliverListConfig<TuChongItem>(
//                      itemBuilder:  itemBuilder,
//                      sourceList: listSourceRepository,
//                      //isLastOne: false
//                    )
//                ),
              ],
            ),
          ),
          OrderAppBar(
            height: 80.0,
            controller: _orderbarcontroller,
            key: _mTitleKey,
          )
        ]
    );

  }

  _questionwidget(_media){
    return Container(
      margin: EdgeInsets.only(top: 785),
      height: 200,
      width: _media.width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10,top: 10,bottom: 20),
            child: Text(
              "您可能遇到以下问题",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                _questioncard("如何评价酒店",_media),
                _questioncard("如何取消/退款",_media),
                _questioncard("查询开票难度",_media)
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                _questioncard("如何申请开票",_media),
                _questioncard("如何删除订单",_media),
                _questioncard("要求开具专票",_media)
              ],
            ),
          )
        ],
      ),
    );
  }
  _paystatustitle(int status){
    if(status == 0){
      return "等待支付";
    }else if(status == 1){
      return "已消费";
    }else{
      return "支付超时";
    }

  }

  _payillustrate(int status){
    if(status == 0){
      return "等待订单支付支付";
    }else if(status == 1){
      return '您的订单已消费，期待您再次预订哦';
    }else{
      return '订单已超过可支付的时间，请重新下单';
    }
  }

  _paybutton(int status){
    if(status == 0){
      return "去支付";
    }else{
      return "再次预定";
    }
  }

  _questioncard(text,_media){
    return Container(
      width: _media.width * 0.3,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(70),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }

  _orderkey(String text){
    return Container(
      padding: EdgeInsets.only(left: 10,top: 10),
      child:Text(
        text,
        style: TextStyle(
            color: Colors.grey,
            fontSize: 15
        ),
      ),
    );
  }

  _ordervalue(String text){
    return  Container(
        padding: EdgeInsets.only(left: 10,top: 10),
        child:Text(
          text,
          style: TextStyle(
              color: Colors.black,
              fontSize: 15
          ),
        )
    );
  }


}
