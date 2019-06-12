import 'package:dio/dio.dart';
import 'package:hotel/entity/hotelview.dart';
import 'package:hotel/entity/roomview.dart';
import 'package:http_client_helper/http_client_helper.dart';
import '../ui/widget/loading_more/loading_more_list.dart';
import '../common/tu_chong_source.dart';
import 'dart:async';
import 'dart:convert';

import 'api.dart';

class TuChongRepository extends LoadingMoreBase<HotelView> {
  int pageindex = 1;

  @override
  // TODO: implement hasMore
  bool _hasMore = true;
  bool forceRefresh = false;
  bool get hasMore => (_hasMore && length < 20);

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    // TODO: implement refresh
    _hasMore = true;
    pageindex = 1;
    var result = await super.refresh(true);
    forceRefresh = false;
    return result;
  }

//  @override
//  Future<bool> refresh([bool clearBeforeRequest = false]) async {
//    // TODO: implement onRefresh
//    _hasMore = true;
//    pageindex = 1;
//    //force to refresh list when you don't want clear list before request
//    //for the case, if your list already has 20 items.
//    forceRefresh = !clearBeforeRequest;
//    var result = await super.refresh(clearBeforeRequest);
//    forceRefresh = false;
//    return result;
//  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    // TODO: implement getData
    String url = "";
    Dio dio = new Dio();
    if (this.length == 0) {
      url = HOTEL_URL;
    } else {
      url = HOTEL_URL;
    }
    bool isSuccess = false;
    try {
      //to show loading more clearly, in your app,remove this
//      await Future.delayed(Duration(milliseconds: 500, seconds: 1));

      var result = await dio.post(url);

      var source = HotelView.fromJson(result.data);
      if (pageindex == 1) {
        this.clear();
      }

      this.add(source);

//      source.feedList.forEach((item) {
//        if (item.hasImage && !this.contains(item) && hasMore) {
//          this.add(item);
//        }
//      });

      _hasMore = true;
      pageindex++;
//      this.clear();
//      _hasMore=false;
      isSuccess = true;
    } catch (exception) {
      isSuccess = false;
      print(exception);
    }
    return isSuccess;
  }
}
