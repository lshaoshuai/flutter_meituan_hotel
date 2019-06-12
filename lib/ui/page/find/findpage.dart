import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import '../../../route/routes.dart';
import '../../../config/application.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindPageState();
}

class _FindPageState extends  State<FindPage> {

  /// The fraction of the viewport that each page should occupy.
  /// Defaults to 1.0, which means each page fills the viewport in the scrolling
  /// direction. 占屏幕比
  final PageController ctrl = PageController(viewportFraction: 0.8);
  List<String> piclist = ['assets/images/beijing2.jpg','assets/images/qidong.jpg','assets/images/beijing1.png'];
  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;
  TextInputFormatter LengthLimitingTextInputFormatter;
  double op = 0;
  int picindex = 0;
  int pageindex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctrl.addListener(() {
      int next = ctrl.page.round();
      if(currentPage == 0){
        setState(() {
          this.op = 0;
        });
      }
      if (currentPage != next) {
        setState(() {
          this.op = 0.3;
          print(next);
          picindex = next;
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      /*appBar: new SearchAppBarWidget(
          backgroundColor: Colors.white,
          elevation: 2.0,
        ),*/
        resizeToAvoidBottomPadding: false,
        body: Material(
            child:Stack(
              fit: StackFit.expand,
              children: <Widget>[
                _backgounderimage(op),
                _CardSlideshow(),
                _searchframe(),
              ],
            )
        )
    );
  }

  Widget _backgounderimage(double op) => Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(op), BlendMode.dstOut),
            image: AssetImage(piclist[picindex]),
            fit: BoxFit.cover,
          )
      )
  );

  ///自定义搜索框
  Widget _searchframe() => Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(left:20,right:20,top: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            ///设置主题颜色
            child: Theme(
                data: new ThemeData(primaryColor: Colors.black54, hintColor: Colors.black54),
                child: TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    fillColor: Colors.transparent.withOpacity(0.2),
                    border: InputBorder.none,
                    hintText: "Search",
                    filled: true,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.clear)
                )
            )
            )
        ),
      )
  );

  _navigate(BuildContext context, String route) {
    Application.navigateTo(context: context, route: route);
  }

  _CardSlideshow(){
    List slideList = ['assets/images/qidong.jpg','assets/images/beijing1.png'];

    return  PageView.builder(
        controller: ctrl,
        itemCount: slideList.length + 1,
        itemBuilder: (context, int currentIdx) {
          bool active = currentIdx == currentPage;
          return currentIdx == 0 ? _buildfirstPage() : _buildStoryPage(active,currentIdx);
        }
    );
  }

  _buildfirstPage(){

    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
        child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 300),
                  child: Text(
                      '收藏', style: TextStyle(fontSize: 40, color: Colors.black)
                  ),
                ),
              ],
            )
        )
    );
  }

  // Builder Functions

  _buildStoryPage(bool active,int index) {
    // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 10 : 0;
    final double top = active ? 130 : 180;
    final double buttom = active ? 20 : 40;


    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
        margin: EdgeInsets.only(top: top, bottom: buttom, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(piclist[index])
            ),

            boxShadow: [BoxShadow(color: Colors.black87,
                blurRadius: blur,
                offset: Offset(offset, offset))
            ]
        ),
        child: InkWell(onTap: () => {},
            child: Center(
                child: Text(
                    'movie', style: TextStyle(fontSize: 40, color: Colors.white))
            )
        )
    );
  }
}