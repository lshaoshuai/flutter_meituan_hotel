import 'package:flutter/material.dart';
import 'package:hotel/ui/widget/loading_more/common/loading_more_sliver_list.dart';
import 'package:hotel/ui/widget/stack_appbar/hotel_appbar.dart';
import '../../widget/MyDivider.dart';

class RoomOrderPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RoomOrderPagePageState();
  }
}

class _RoomOrderPagePageState extends State<RoomOrderPage>{

  ScrollController _scrollcontroller = ScrollController();
  HotelBarController _hotelbarcontroller = new HotelBarController();
  bool _isNeedSetAlpha = false;
  GlobalKey<HotelAppBarState>_mTitleKey = new GlobalKey();
  List<String> list = ['1','2','3'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _hotelbarcontroller.value.alpha = 0;

    _scrollcontroller.addListener(() {

      if ( _scrollcontroller.offset < 80.0) {
        _isNeedSetAlpha = true;
        _hotelbarcontroller.value.alpha = ((_scrollcontroller.offset / 80) * 255).toInt();
        _mTitleKey.currentState.setState(() {});
      } else {
        if (_isNeedSetAlpha) {
          _hotelbarcontroller.value.alpha = 255;
          _mTitleKey.currentState.setState(() {});
          _isNeedSetAlpha = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _mainpage(context),
    );
  }
  _mainpage(context){
    final _media = MediaQuery.of(context).size;
    return Stack(
        children: <Widget>[
          Container(
            height: _media.height,
            child: LoadingMoreCustomScrollView(
              showGlowLeading: false,
              controller: _scrollcontroller,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 80.0),
                        child: Text(
                          '七彩假日酒店公寓',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 80.0),
                        child: Text(
                          '七彩假日酒店公寓',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 80.0),
                        child: Text(
                          '七彩假日酒店公寓',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          ),
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
          HotelAppBar(
            height: 80.0,
            controller: _hotelbarcontroller,
            key: _mTitleKey,
          ),
          Container(
            margin: EdgeInsets.only(top: _media.height - 70.0),
            height: 70.0,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                MyDivider(height: 0,width: 0.1),
                Row(
                  children: <Widget>[
                    Container(
                      width: _media.width * 0.5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              '￥66',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 25,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              '已优惠￥14',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: _media.width * 0.5,
                      height: 70.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.deepOrangeAccent, Colors.redAccent]
                        ),
                      ),
                      child: GestureDetector(
                        child: Center(
                          child: Text(
                            '提交订单',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ]
    );
  }
}
