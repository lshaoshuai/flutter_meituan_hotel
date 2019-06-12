/**
 * 路由定义
 * Create by Songlcy
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hotel/entity/hotelview.dart';
import 'package:hotel/ui/page/login/codepage.dart';
import 'package:hotel/ui/page/login/loginpage.dart';
import 'package:hotel/ui/page/mainpage.dart';
import 'package:hotel/ui/page/pay/successpage.dart';
import 'package:hotel/ui/page/personal/ippage.dart';
import 'package:hotel/ui/page/personal/settingpage.dart';
import 'package:hotel/ui/page/room/room_order_page.dart';
import 'package:hotel/ui/page/personal/personalpage.dart';
import '../ui/page/hotely/hotel_list_page.dart';
import '../ui/page/hotely/hotel_detail_page.dart';
import '../ui/page/order/order_detail_page.dart';

var hotelpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return HotelPage();
    }
);
var hoteldetailpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return HotelDetailPage();
    }
);

var orderdetailpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return OrderDetailPage();
    }
);


var roomorderpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return RoomOrderPage();
    }
);

var loginpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return LoginPage();
    }
);

var codepageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      String phone_num = params["phone_num"]?.first;
      String verifyCode = params["verifyCode"]?.first;
      return CodePage(
          phone_num:phone_num,
          verifyCode:verifyCode,
      );
    }
);

var personpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      String islogin = params["islogin"]?.first;

      return PersonPage(

        islogin: islogin == "true"?true:false,
      );
    }
);

var mainpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return MainPage();
    }
);

var settingpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return SettingPage();
    }
);


var successpageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return SuccessPage();
    }
);

var ippageRouteHandler = Handler(
    handlerFunc: (BuildContext context,Map<String, List<String>> params){
      return IpPage();
    }
);