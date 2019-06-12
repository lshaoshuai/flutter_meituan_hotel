import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel/common/api.dart';
import 'package:hotel/common/constant.dart';
import 'package:hotel/entity/hotelview.dart';
import 'package:hotel/entity/roomview.dart';
import 'package:hotel/http/service/NetService.dart';
import 'package:hotel/ui/page/pay/paypage.dart';
import 'package:hotel/ui/widget/loading_more/common/loading_more_sliver_list.dart';
import 'package:hotel/ui/widget/progress/CustomProgressIndicator.dart';
import 'package:hotel/ui/widget/progress/progressdialog.dart';
import 'package:hotel/ui/widget/stack_appbar/order_detail_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/MyDivider.dart';

class RoomOrderPage extends StatefulWidget{

  RoomView roomView;
  HotelView hotelView;
  RoomOrderPage({
    @required
    this.roomView,
    this.hotelView,});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RoomOrderPagePageState();
  }
}

class _RoomOrderPagePageState extends State<RoomOrderPage> {

  ScrollController _scrollcontroller = ScrollController();
  OrderDetailBarController _hotelbarcontroller = new OrderDetailBarController();
  bool _isNeedSetAlpha = false;
  GlobalKey<OrderDetailAppBarState>_mTitleKey = new GlobalKey();
  TextEditingController _textEditingController = new TextEditingController();
  TextEditingController _textUserEditingController = new TextEditingController();
  String username = "";
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _hotelbarcontroller.value.alpha = 0;

    _scrollcontroller.addListener(() {
      if (_scrollcontroller.offset < 80.0) {
        _isNeedSetAlpha = true;
        _hotelbarcontroller.value.alpha =
            ((_scrollcontroller.offset / 80) * 255).toInt();
        _mTitleKey.currentState.setState(() {});
      } else {
        if (_isNeedSetAlpha) {
          _hotelbarcontroller.value.alpha = 255;
          _mTitleKey.currentState.setState(() {});
          _isNeedSetAlpha = false;
        }
      }
    });

    getStorageString(USER_NAME);
    _textEditingController.text = "1";

  }

  Future getStorageString(key) async {
    setState(() {
      _loading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.get(key);
      _textUserEditingController.text = username;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final _media = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(240),
      body: ProgressDialog(
        loading: _loading,
        progress: CustomProgressIndicator.HeartBeat(_media),
        child: _mainpage(context,_media),
      ),
    );
  }

  _mainpage(context,_media) {

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
                          margin: EdgeInsets.only(top: 90.0,left: 15),
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.hotelView.hotel_name ?? "",
                            style: TextStyle(
                                fontFamily: fontname,
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0,left: 15),
                          alignment: Alignment.topLeft,
                          child: Text(
                            _actiondate(selectDate) + "-" + _actiondate(secselectDate)+ " 共" + secselectDate.difference(selectDate).inDays.toString() + "天",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0,left: 15),
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.roomView.room_name ?? "",
                            style: TextStyle(
                                fontFamily: fontname,
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                        ),
                        Container(
                            height: 100,
                            width: _media.width * 0.95,
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      _actionicon(Icons.sentiment_very_satisfied,Colors.redAccent),
                                      _actiontext("赞！您已选择本店最划算的客房！",Colors.redAccent)
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      _actionicon(Icons.card_giftcard,Colors.redAccent),
                                      _actiontext("Hotel酒店金卡会员尊享订房优惠。",Colors.redAccent)
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      _actionicon(Icons.check_circle,Colors.blueGrey),
                                      _actiontext("放心订！预定成功后15分钟内可免费取消",Colors.blueGrey)
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                          width: _media.width,
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 15,top: 20,bottom: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: _media.width * 0.2,
                                        child: Text(
                                          '房间数',
                                        ),
                                      ),
                                      Container(
                                          width: _media.width * 0.5,
                                          child: TextField(
                                              cursorWidth: 0,
                                              controller: _textEditingController,

                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                border: InputBorder.none,
                                                filled: true,
                                                contentPadding: EdgeInsets.only(top: 5.0),
                                              )
                                          )
                                      ),
                                      Container(
                                        width: _media.width * 0.2,
                                        alignment: Alignment.centerRight,
                                        child:Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                          size: _media.width / 20,
                                        ),
                                      )

                                    ],
                                  )
                              ),
                              MyDivider(height: 0,width: 0.5,),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 15,top: 20,bottom: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: _media.width * 0.15,
                                        child: Text('入住人'),
                                      ),
                                      Container(
                                        width: _media.width * 0.1,
                                        alignment: Alignment.centerLeft,
                                        child:Icon(
                                          Icons.help_outline,
                                          color: Colors.grey,
                                          size: _media.width / 30,
                                        ),
                                      ),
                                      Container(
                                          width: _media.width * 0.5,
                                          child: TextField(
                                              cursorWidth: 0,
                                              controller: _textUserEditingController,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                border: InputBorder.none,
                                                filled: true,
                                                contentPadding: EdgeInsets.only(top: 5.0),
                                              )
                                          )
                                      ),
                                      Container(
                                        width: _media.width * 0.15,
                                        alignment: Alignment.centerRight,
                                        child:Icon(
                                          Icons.perm_identity,
                                          color: Colors.grey,
                                          size: _media.width / 15,
                                        ),
                                      )

                                    ],
                                  )
                              ),
                              MyDivider(height: 0,width: 0.5),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 15,top: 20,bottom: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: _media.width * 0.2,
                                        child: Text('联系手机'),
                                      ),
                                      Container(
                                          width: _media.width * 0.5,
                                          child: TextField(
                                              cursorWidth: 0,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                border: InputBorder.none,
                                                filled: true,
                                                contentPadding: EdgeInsets.only(top: 5.0),
                                              )
                                          )
                                      ),
                                      Container(
                                        width: _media.width * 0.2,
                                        alignment: Alignment.centerRight,
                                        child:Icon(
                                          Icons.contact_phone,
                                          color: Colors.grey,
                                          size: _media.width / 15,
                                        ),
                                      )
                                    ],
                                  )
                              ),
                              MyDivider(height: 0,width: 0.5),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 15,top: 20,bottom: 20),
                                child: Text('预计到店'),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: _media.width,
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 15,top: 20,bottom: 20),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "优惠",
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child:Icon(
                                        Icons.card_giftcard,
                                        color: Colors.redAccent,
                                        size: _media.width / 25,
                                      ),
                                      margin: EdgeInsets.only(left: 20),
                                    ),
                                    Container(
                                      child: Text(
                                        "已为您选择最大优惠",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: _media.width / 30
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.redAccent,),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      padding: EdgeInsets.all(1),

                                    )
                                  ],
                                ),
                              ),
                              MyDivider(height: 0,width: 0.5),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 15,top: 20,bottom: 20),
                                child:  Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "优惠卷",
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: _media.width,
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 10.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 15,top: 20,bottom: 20),
                            child:  Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "发票",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      child: Text(
                                        "如需发票，请向前台索取",
                                      ),
                                      padding: EdgeInsets.only(left: 40),
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                            height: 300,
                            width: _media.width,
                            margin: EdgeInsets.only(top: 10.0,left: 15),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '退款规则',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                    ),
                                  ) ,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    '根据酒店政策，预定成功后不可'
                                        '取消/变更，如未入住，酒店将扣除全额房费。预定成功后15分钟内可免费取消'
                                        '无需商家同意即可马上退款至您的原支付账户（限入住日24点前），极速退款权益'
                                        '不受酒店取消政策限制。',
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )
                      ],
                    )
                )
              ],
            ),
          ),
          OrderDetailAppBar(
            height: 80.0,
            controller: _hotelbarcontroller,
            key: _mTitleKey,
            hotelTitle: widget.hotelView.hotel_name ?? "",
          ),
          Container(
            margin: EdgeInsets.only(top: _media.height - 65.0),
            height: 65.0,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                MyDivider(height: 0, width: 0.1),
                Row(
                  children: <Widget>[
                    Container(
                      width: _media.width * 0.5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.roomView.room_price.toString()??"",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.topLeft,
                            child: Text(
                              '已优惠'+'\$'+'14',
                              style: TextStyle(
                                fontFamily: fontname,
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
                      height: 65.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.deepOrangeAccent, Colors.redAccent]
                        ),
                      ),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            _loading = true;
                          });
                          NetService.post(CREATE_ORDER_URL, (response){
                            print(response.data['result']);
                            setState(() {
                              _loading = false;
                            });
                            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                              return PayPage(
                                room_id: widget.roomView.id,
                                roomView: widget.roomView,
                                orderid: response.data['result']
                              );
                            }));
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

                          },params: {
                            'room_name': widget.roomView.room_name,
                            'room_id': widget.roomView.id.toString(),
                            'room_count': _textEditingController.text,
                            'collection_price': (widget.roomView.room_price * int.parse(_textEditingController.text)).toString(),
                            'room_out_time': DateUtil.getDateStrByDateTime(secselectDate,format:  DateFormat.YEAR_MONTH_DAY),
                            'room_in_time': DateUtil.getDateStrByDateTime(selectDate,format:  DateFormat.YEAR_MONTH_DAY),
                            'user_id': username,
                            'hotel_name': widget.hotelView.hotel_name,
                          });

                        },
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

  _totalday(DateTime datetime,DateTime otherdatetime){
    return (datetime.day - otherdatetime.day).toString();
  }

  _actiondate(DateTime datetime){
    return datetime.month.toString() + "月" + datetime.day.toString() + "日";
  }

  _actionicon(IconData icon,Color iconcolor) {
    return Padding(
      child: Icon(
        icon,
        size: 20,
        color: iconcolor,
      ),
      padding: EdgeInsets.only(left: 10, top: 10),
    );
  }

  _actiontext(String text,Color textcolor) {
    return
      Padding(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: fontname,
              color: textcolor,
              fontSize: 15
          ),
        ),
        padding: EdgeInsets.only(left: 10, top: 10),
      );
  }
}
