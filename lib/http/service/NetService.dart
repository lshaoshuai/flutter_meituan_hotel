import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hotel/common/api.dart';
import 'package:hotel/common/constant.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class NetService {

  static const String GET = 'GET';
  static const String POST = 'POST';

  static Map<String, String> Headers = {
    HttpHeaders.authorizationHeader : ""
  };

  //get请求
  static void get(String url, Function successCallBack,
      {Map<String, String> params, Function errorCallBack}) {
    _request(url, successCallBack,
        method: GET, params: params, errorCallBack: errorCallBack);
  }

  //post请求
  static void post(String url, Function successCallBack,
      {Map<String, String> params, Map<String,String> headers,Function errorCallBack}) {
    print("post:${url}");
    _request(url, successCallBack,
        method: POST, params: params, headers: headers, errorCallBack: errorCallBack);
  }

  static Future getStorageString(key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.get(key);
    print("get token:${token}");
    if(token!=null)
    {
      Headers[HttpHeaders.authorizationHeader] ='Bearer '+ token;
    }

  }
  // 请求部分
  static void _request(String url, Function callBack,
      {String method, Map<String, String> params, Map<String,String> headers, Function errorCallBack}) async {
    String errorMsg = "";
    int statusCode;

    try {
      Response response;
      getStorageString(TOKEN_KEY);
      print("headers:${Headers}");
      Options options= new Options(
        // 15s 超时时间
          connectTimeout:1000,
          receiveTimeout:1000,
          baseUrl: BASE_URL,
          headers: Headers
        // dio库中默认将请求数据序列化为json，此处可根据后台情况自行修改
        //contentType: new ContentType('application', 'x-www-form-urlencoded',charset: 'utf-8')
      );
      Dio dio = new Dio(options);

      if (method == GET) {
        response = await dio.get(url,data: params);

      } else {
        response = await dio.post(url,data: params);
      }
      statusCode = response.statusCode;
      //处理错误部分
      if (statusCode < 0) {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
        return;
      }

      if (callBack != null) {
        callBack(response);
        print(response.statusCode);
      }
    } catch (exception) {
      _handError(errorCallBack, exception.toString());
    }
  }

  //处理异常
  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }



}