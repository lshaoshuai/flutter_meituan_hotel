import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hotel/common/api.dart';

class MySwiper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MySwiperState();
  }
}

class _MySwiperState extends State<MySwiper> with SingleTickerProviderStateMixin{

  List<String> bannerlists = [BASE_URL + HOTEL_BASE_PORT + '/image/banner1.jpg',BASE_URL + HOTEL_BASE_PORT +  '/image/banner2.jpg',BASE_URL + HOTEL_BASE_PORT +  '/image/banner3.jpg',
  BASE_URL + HOTEL_BASE_PORT +  '/image/banner3.jpg'];

  TabController tabController;
  var currentPage = 0;
  var isPageCanChanged = true;
  PageController pageController = PageController(initialPage: 0,viewportFraction: 0.8);
  final List<Tab> tablist = <Tab>[
    new Tab(text: '国内'),
    new Tab(text: '钟点房'),
    new Tab(text: '国际/港澳台'),
    new Tab(text: '民宿公寓'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: tablist.length,
      vsync: this,
    );

    tabController.addListener(() {//TabBar的监听
      if (tabController.indexIsChanging) {//判断TabBar是否切换
        print(tabController.index);
        //onPageChange(tabController.index, p: pageController);
        onPageChange(tabController.index, p: pageController);
      }
    });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {//判断是哪一个切换
      isPageCanChanged = false;
      await pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);//等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    } else {
      tabController.animateTo(index);//切换Tabbar
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(top: 30,bottom: 15),
        height: 110,
        width: 450,
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                  controller: pageController,
                  itemCount: bannerlists.length,
                  onPageChanged: (index) {
                    if (isPageCanChanged) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                      onPageChange(index);
                    }
                  },
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
                        )
                    );
                  }
              ) ,
            ),
            TabPageSelector(
              color: Colors.redAccent.withAlpha(200),
              indicatorSize: 8,
              controller: tabController,
            ),
          ],
        )
    );
  }
}