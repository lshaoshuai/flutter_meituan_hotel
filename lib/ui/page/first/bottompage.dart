import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hotel/common/api.dart';
import 'package:hotel/common/constant.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

import '../../widget/ad_swiper/swiper.dart';
import '../hotely/hotel_item.dart';

class BottomPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomPageState();
  }
}
class _BottomPageState extends State<BottomPage> with SingleTickerProviderStateMixin{


  List<String> bannerlists = [BASE_URL + HOTEL_BASE_PORT + '/image/ad1.jpg',BASE_URL + HOTEL_BASE_PORT +  '/image/ad2.jpg',BASE_URL + HOTEL_BASE_PORT +  '/image/ad3.jpg'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bottompage(context);
  }

  Widget _swiperBuilder(BuildContext context, int index) {

    final _media = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          width: _media.width,
          child: Image.network(
            bannerlists[index],
            fit: BoxFit.cover,
          ),
        ),
        Container(
            height: 80,
            width: _media.width * 0.35,
            margin: EdgeInsets.only(left: 10,top: 10),
            child: Card(
              elevation: 0,
              color: Colors.white.withAlpha(20),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 10,top: 10),
                    child: Text(
                      '限时抢',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: 10,top: 10),
                    child: Text(
                      '今夜尾房甩卖',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: fontname,
                          fontSize: 15
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ],
    );
  }

  Widget bottompage(BuildContext context) {

    final _media = MediaQuery.of(context).size;
    PageController pageController = PageController(initialPage: 0,viewportFraction: 0.35);

    return Container(
      child: Column(
        children: <Widget>[
          MySwiper(),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 230.0,
              padding: EdgeInsets.only(top: 20),
              child: Container(
                width: 300,
                child: Swiper(
                  itemBuilder: _swiperBuilder,
                  itemCount: 3,
                  pagination: new SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.black54,
                        activeColor: Colors.white,
                      )),
                  control: new SwiperControl(
                      iconNext: null,
                      iconPrevious: null
                  ),
                  scrollDirection: Axis.horizontal,
                  autoplay: true,
                  onTap: (index) => print('点击了第$index个'),
                ),
              )
          ),
          Container(
              margin: EdgeInsets.only(left: 10,bottom: 10,top: 40),
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Padding(
                    child: Icon(
                      Icons.fiber_new,
                      color: Colors.deepOrange,
                    ),
                    padding: EdgeInsets.only(right: 5),
                  ),
                  Text('特惠精选',
                    style: TextStyle(
                        fontFamily: 'jindian',
                        fontWeight: FontWeight.w700,
                        fontSize: 23
                    ),
                  ),
                ],
              )
          ),
          Container(
              height: 100,
              width: 500,
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: bannerlists.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(bannerlists[index])
                                  ),
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                            );

                          }
                      )
                  )
                ],
              )
          ),
          Container(
              margin: EdgeInsets.only(left: 10,bottom: 10,top: 40),
              alignment: Alignment.topLeft,
              child:Row(
                  children: <Widget>[
                    Padding(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.deepOrange,
                      ),
                      padding: EdgeInsets.only(right: 5),
                    ), Text(
                      '推荐榜单',
                      style: TextStyle(
                          fontFamily: 'jindian',
                          fontWeight: FontWeight.w700,
                          fontSize: 23
                      ),
                    ),
                  ]
              )
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height:160,
                          width: _media.width * 0.48,
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(BASE_URL + HOTEL_BASE_PORT + '/image/ad4.jpg')
                            ),
                          ),

                        ),
                        Container(
                          height:160,
                          width: _media.width * 0.48,
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(BASE_URL + HOTEL_BASE_PORT + '/image/ad5.jpg')
                            ),
                          ),
                        )
                      ],
                    )
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height:_media.width * 0.31,
                        width: _media.width * 0.31,
                        margin: EdgeInsets.only(left: 5,top: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(BASE_URL + HOTEL_BASE_PORT + '/image/ad6.jpg')
                          ),
                        ),
                      ),
                      Container(
                        height:_media.width * 0.31,
                        width: _media.width * 0.31,
                        margin: EdgeInsets.only(left: 5,top: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(BASE_URL + HOTEL_BASE_PORT + '/image/ad7.jpg')
                          ),
                        ),
                      ),
                      Container(
                          height:_media.width * 0.31,
                          width: _media.width * 0.31,
                          margin: EdgeInsets.only(left: 5,top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(BASE_URL + HOTEL_BASE_PORT + '/image/ad1.jpg')
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 10,bottom: 10,top: 40),
              alignment: Alignment.centerLeft,
              child: Row(
                  children: <Widget>[
                    Padding(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.deepOrange,
                      ),
                      padding: EdgeInsets.only(right: 5),
                    ),Text(
                      '猜你喜欢',
                      style: TextStyle(
                          fontFamily: 'jindian',
                          fontWeight: FontWeight.w700,
                          fontSize: 23
                      ),
                    ),
                  ]
              )
          ),
        ],
      ),
    );
  }
}