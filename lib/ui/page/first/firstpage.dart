import 'package:flutter/material.dart';
import 'package:hotel/entity/hotelview.dart';
import '../../widget/MyDivider.dart';
import '../hotely/hotel_item.dart';
import '../../widget/loading_more/loading_more_list.dart';
import '../../../common/tu_chong_repository.dart';
import 'Internationalpage.dart';
import 'babpage.dart';
import 'bottompage.dart';
import 'hourroompage.dart';
import 'inlandpage.dart';
import 'customtilebar.dart';

class FirstPage extends StatefulWidget {

  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>  with SingleTickerProviderStateMixin {

  TuChongRepository listSourceRepository;
  ScrollController _scrollcontroller = new ScrollController();
  GlobalKey<CustomTitleBarState>_mTitleKey = new GlobalKey();
  GlobalKey<NavigatorState>_firstpagekey = new GlobalKey();
  var currentPage = 0;
  var isPageCanChanged = true;
  CustomTitleBarController _mCustomTitleBarController = new CustomTitleBarController();
  TabController tabController;
  //PageController pageController = PageController(initialPage: 0);
  var cardheight = 410.0;
  final List<double> cardheightlist = <double>[410.0,280.0,475.0,410.0];

  List<String> list = ['1','2','3'];
  final List<Tab> tablist = <Tab>[
    new Tab(text: '国内'),
    new Tab(text: '钟点房'),
    new Tab(text: '国际/港澳台'),
    new Tab(text: '民宿公寓'),
  ];

  List<Widget> pagelist = List();
  List<Widget> bottompagelist = List();
  bool _isNeedSetAlpha = false;

  @override
  void initState() {
    super.initState();

    pagelist
      ..add(InlandPage())
      ..add(HourroomPage())
      ..add(InternationalPage())
      ..add(BabPage());


    tabController = TabController(
      length: tablist.length,
      vsync: this,
    );

    tabController.addListener(() {//TabBar的监听
      if (tabController.indexIsChanging) {//判断TabBar是否切换
        print(tabController.index);
        //onPageChange(tabController.index, p: pageController);
        setState(() {
          currentPage = tabController.index;
          cardheight = cardheightlist[tabController.index];
        });
      }
    });

    _mCustomTitleBarController.value.alpha = 0;

    _scrollcontroller.addListener(() {
      if ( _scrollcontroller.offset < 80.0) {
        _isNeedSetAlpha = true;
        _mCustomTitleBarController.value.alpha = ((_scrollcontroller.offset / 80) * 255).toInt();
        _mTitleKey.currentState.setState(() {});
      } else {
        if (_isNeedSetAlpha) {
          _mCustomTitleBarController.value.alpha = 255;
          _mTitleKey.currentState.setState(() {});
          _isNeedSetAlpha = false;
        }
      }
    });

    listSourceRepository = new TuChongRepository();
  }

  /*onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {//判断是哪一个切换
      isPageCanChanged = false;
      await pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);//等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    } else {
      tabController.animateTo(index);//切换Tabbar
    }
  }*/

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: _mainbody(context)
    );
  }


  _mainbody(BuildContext context){

    final _media = MediaQuery.of(context).size;
    final cardwt = _media.width * 0.97;

    return  Stack(
        children: <Widget>[
          new Container(
            height: _media.height,
            child: LoadingMoreCustomScrollView(
              showGlowLeading: false,
              controller: _scrollcontroller,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                              height: _media.height * 0.33,
                              decoration: new BoxDecoration(
                                //渐变色
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.red.withAlpha(230),
                                        Colors.redAccent.withAlpha(220),
                                      ],
                                      begin: const FractionalOffset(0.2, 0.0),
                                      end: const FractionalOffset(1.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp
                                  )
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 80, left: _media.width / 2 - cardwt / 2),
                            height: cardheight,
                            width: cardwt,
                            child: Card(
                                color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    TabBar(
                                      isScrollable: true,
                                      //是否可以滚动
                                      controller: tabController,
                                      indicatorColor : Colors.red,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorWeight: 3.0,
                                      labelColor: Colors.black,
                                      labelPadding: EdgeInsets.symmetric(horizontal: _media.width / 35),
                                      unselectedLabelColor: Color(0xff666666),
                                      unselectedLabelStyle: TextStyle(
                                        fontFamily: 'jindian',
                                        fontSize: _media.width / 22,
                                      ),
                                      labelStyle: TextStyle(
                                        fontFamily: 'jindian',
                                        fontSize: _media.width / 23,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      tabs: tablist.map((item) {
                                        return Tab(
                                          text: item.text,
                                        );
                                      }).toList(),
                                    ),
                                    MyDivider(height: 0, indent: _media.width / 30, endindent: _media.width / 30,),
                                    Expanded(
                                      child: pagelist[currentPage],
                                    )
                                  ],
                                )
                            ),
                          )
                        ],
                      ),
                      BottomPage()
                    ],
                  ),
                ),
                LoadingMoreSliverList(
                    SliverListConfig<HotelView>(
                      itemBuilder:  itemBuilder,
                      sourceList: listSourceRepository,
                      //isLastOne: false
                    )
                ),
              ],
            ),
          ),
          CustomTitleBar(
            height: 80.0,
            controller: _mCustomTitleBarController,
            key: _mTitleKey,
          ),
        ]
    );
  }

  Widget itemBuilder(BuildContext context,HotelView item, int index) => HotelItem(hotelView: item,);

}
