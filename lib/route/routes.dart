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
  static String loginpage = "/loginpage";
  static String codepage = "/codepage";
  static String personpage = "/personpage";
  static String mainpage = "/mainpage";
  static String settingpage = "/settingpage";
  static String successpage = "/successpage";
  static String ippage = "/ippage";


  static void configureRoutes(Router router) {


    router.define(hotelpage, handler: hotelpageRouteHandler);
    router.define(hoteldetailpage, handler: hoteldetailpageRouteHandler);
    router.define(orderdetailpage, handler: orderdetailpageRouteHandler);
    router.define(roomorderpage, handler: roomorderpageRouteHandler);
    router.define(loginpage, handler: loginpageRouteHandler);
    router.define(codepage, handler: codepageRouteHandler);
    router.define(personpage, handler: personpageRouteHandler);
    router.define(mainpage, handler: mainpageRouteHandler);
    router.define(settingpage, handler: settingpageRouteHandler);
    router.define(successpage, handler: successpageRouteHandler);
    router.define(ippage, handler: ippageRouteHandler);
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
        });
  }
}
