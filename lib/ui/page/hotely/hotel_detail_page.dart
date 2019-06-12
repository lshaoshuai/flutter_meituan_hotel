import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel/common/api.dart';
import 'package:hotel/common/constant.dart';
import 'package:hotel/common/tu_chong_repository.dart';
import 'package:hotel/common/tu_chong_source.dart';
import 'package:hotel/entity/hotelview.dart';
import 'package:hotel/entity/roomview.dart';
import 'package:hotel/http/service/NetService.dart';
import 'package:hotel/ui/widget/bottom_pop/timebottompop.dart';
import 'package:hotel/ui/widget/progress/CustomProgressIndicator.dart';
import 'package:hotel/ui/widget/progress/progressdialog.dart';
import 'package:hotel/ui/widget/stack_appbar/hotel_appbar.dart';
import '../../widget/MyDivider.dart';
import '../../widget/loading_more/loading_more_list.dart';
import 'hotel_item.dart';
import '../room/room_order_item.dart';

class HotelDetailPage extends StatefulWidget{

  HotelView hotelView;

  HotelDetailPage({
    @required this.hotelView
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HotelDetailPageState();
  }
}

class _HotelDetailPageState extends State<HotelDetailPage>{

  TuChongRepository listSourceRepository;
  ScrollController _scrollcontroller = ScrollController();
  HotelBarController _hotelbarcontroller = new HotelBarController();
  bool _isNeedSetAlpha = false;
  GlobalKey<HotelAppBarState>_mTitleKey = new GlobalKey();
  List<RoomView> room_list = [];
  bool _loading = true;
  String token = null;
  Map<String,String> Headers = new HashMap();

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
    listSourceRepository = new TuChongRepository();
  }

  @override
  void dispose() {
    //注意这里关闭
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _loading = true;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('didChangeDependencies');
    NetService.post(ROOM_URL, (response){
      print(response);
      setState(() {
        room_list.clear();
        _loading = false;
        for(var s in response.data['result']){
          room_list.add(new RoomView.fromJson(s));
        }
      });
    },errorCallBack: (errorMsg){
      print(errorMsg);
      setState(() {
        _loading = !_loading;
      });
      Fluttertoast.showToast(
          msg: "网络请求异常，获取不到酒店信息",
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

    final _media = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressDialog(
        loading: _loading,
        progress: CustomProgressIndicator.HeartBeat(_media),
        child: _mainpage(_media),
      )
    );
  }
  _mainpage(_media){

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
                            height: 300,
                            width: _media.width,
                            child: Image.network(
                              'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1211820406,3634865743&fm=26&gp=0.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 180,
                            margin: EdgeInsets.only(top: 200,left: 30),
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.all(Radius.circular(5.0))
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text(
                                    widget.hotelView.hotel_grade??"",
                                    style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      border: Border(left: BorderSide(color: Colors.white30,width: 0.5))
                                  ),
                                  child: Text(
                                    "哈尔滨情侣必去",
                                    style: TextStyle(
                                      fontFamily: fontname,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 280),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0))
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 20,left: 20),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.hotelView.hotel_name??"",
                                    style: TextStyle(
                                        fontFamily: fontname,
                                        fontWeight: FontWeight.w600,
                                        fontSize: _media.width / 15
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10,left: 20,bottom: 10),
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: _media.width * 0.7,
                                          child: Text(
                                            widget.hotelView.hotel_location??"",
                                            softWrap: true,
                                            style: TextStyle(
                                                fontFamily: fontname,
                                                fontWeight: FontWeight.w200,
                                                fontSize: _media.width / 20
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                          },
                                          child: Container(
                                              width: _media.width * 0.15,
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.blueAccent,
                                                    size: _media.width / 20,
                                                  ),
                                                  Text(
                                                    "地图/导航",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w200,
                                                        fontSize: _media.width / 30,
                                                        color: Colors.blueAccent
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                MyDivider(height: 0,width: 0.5,endindent: 30,indent: 30,),
                                InkWell(
                                    onTap: (){
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context){
                                            //showModalBottomSheet默认点击子widget收起，加一个GestureDetector并设置onTap为false阻断点击事件
                                            return GestureDetector(
                                              onTap: () => false,
                                              child: TimeBottomPop(
                                                onChange: (m){
                                                  print(m);
                                                },
                                              ),
                                            );
                                          }
                                      ).then((value){
                                        setState(() {
                                          if(value!=null && !value.isEmpty){
                                            selectDate = value[0];
                                            secselectDate = value[1];
                                          }
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 65,
                                      child:Row(
                                        children: <Widget>[
                                          Container(
                                            width:_media.width * 0.85,
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  width: _media.width * 0.85 * 0.4,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          checksameday(selectDate,DateTime.now())? '今天入住' : '入住',
                                                          style: TextStyle(
                                                              fontFamily: fontname,
                                                              fontSize: 13,
                                                              color: Colors.red
                                                          ),
                                                        ),
                                                        padding: EdgeInsets.only(left: 20,top: 10),
                                                      ),
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          selectDate.month.toString() + "月" + selectDate.day.toString() + "日",
                                                          style:TextStyle(
                                                            fontFamily: fontname,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        padding: EdgeInsets.only(left:20,top: 3),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  width:_media.width * 0.85 * 0.4,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          checksameday(secselectDate,DateTime.now().add(Duration(days: 1)))?'明天离店': '离店' ,
                                                          style: TextStyle(
                                                              fontFamily: fontname,
                                                              fontSize: 13,
                                                              color: Colors.red
                                                          ),
                                                        ),
                                                        padding: EdgeInsets.only(left: 10,top: 10),
                                                      ),
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child:Text(
                                                          secselectDate.month.toString() + "月" + secselectDate.day.toString() + "日",
                                                          style:TextStyle(
                                                            fontFamily: fontname,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        padding: EdgeInsets.only(left: 10,top: 3),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(
                                                        '共'+ secselectDate.difference(selectDate).inDays.toString() +'晚',
                                                        style: TextStyle(
                                                            fontFamily: fontname,
                                                            color: Colors.black,
                                                            fontSize: 11
                                                        ),
                                                      ),
                                                    )
                                                )
                                              ],
                                            ) ,
                                          ),
                                          Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 0),
                                                child:Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 20,
                                                    color: Colors.grey),
                                              )
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (context,int index){
                        return  RoomItem(
                            roomView : room_list[index],
                            hotelView : widget.hotelView,
                        );
                      },
                      childCount: room_list.length
                  ),
                )
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
          HotelAppBar(
            height: 80.0,
            controller: _hotelbarcontroller,
            key: _mTitleKey,
            hotelTitle: widget.hotelView.hotel_name??"",
          )
        ]
    );
  }

  Widget itemBuilder(BuildContext context,TuChongItem item, int index) => HotelItem();

  bool checksameday(DateTime datetime,DateTime ct){

    if(datetime.month == ct.month) {
      if (datetime.day == ct.day){
        return true;
      }
    }
    return false;

  }

}
