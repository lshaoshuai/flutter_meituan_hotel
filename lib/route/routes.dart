/**
 * 路由配置
 * Create by Songlcy
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String webview = "/webview";
  static String hotelpage = "/hotelpage";
  static String hoteldetailpage = "/hoteldetailpage";
  static String orderdetailpage = "/orderdetailpage";
  static String roomorderpage = "/roomorderpage";

  static void configureRoutes(Router router) {


    router.define(hotelpage, handler: hotelpageRouteHandler);
    router.define(hoteldetailpage, handler: hoteldetailpageRouteHandler);
    router.define(orderdetailpage, handler: orderdetailpageRouteHandler);
    router.define(roomorderpage, handler: roomorderpageRouteHandler);
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
        });
  }
}
