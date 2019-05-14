import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bottompage(context);
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (
        Image.asset(
          "assets/images/2.jpg",
          fit: BoxFit.fill,
        ));
  }

  Widget bottompage(BuildContext context) {

    final _media = MediaQuery.of(context).size;
    List<String> list = ['1','2','3'];
    PageController pageController = PageController(initialPage: 0,viewportFraction: 0.3);

    return Container(
      child: Column(
        children: <Widget>[
          MySwiper(),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
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
                  control: new SwiperControl(),
                  scrollDirection: Axis.horizontal,
                  autoplay: true,
                  onTap: (index) => print('点击了第$index个'),
                ),
              )
          ),
          Container(
            margin: EdgeInsets.only(left: 10,bottom: 10,top: 40),
            alignment: Alignment.centerLeft,
            child: Text('特惠精选',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 23
              ),
            ),
          ),
          Container(
              height: 100,
              width: 500,
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage( fit: BoxFit.cover,image: AssetImage('assets/images/3.jpg')),
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
            child: Text('推荐榜单',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 23
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height:160,
                          width: _media.width * 0.5,
                          child: Card(
                            color: Colors.redAccent,
                          ),
                        ),
                        Container(
                          height:160,
                          width: _media.width * 0.5,
                          child: Card(
                            color: Colors.redAccent,
                          ),
                        )
                      ],
                    )
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height:_media.width * 0.33,
                        width: _media.width * 0.33,
                        child: Card(
                          color: Colors.redAccent,
                        ),
                      ),
                      Container(
                        height:_media.width * 0.33,
                        width: _media.width * 0.33,
                        child: Card(
                          color: Colors.redAccent,
                        ),
                      ),
                      Container(
                        height:_media.width * 0.33,
                        width: _media.width * 0.33,
                        child: Card(
                          color: Colors.redAccent,
                        ),
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
            child: Text('猜你喜欢',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 23
              ),
            ),
          ),
        ],
      ),
    );
  }

}