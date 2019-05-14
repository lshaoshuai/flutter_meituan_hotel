/**
 * 路由定义
 * Create by Songlcy
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hotel/ui/page/order/room_order_page.dart';
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