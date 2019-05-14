import 'package:flutter/material.dart';
import '../calendar/calendar.dart';

class TimeBottomPop extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TimeBottomPopState();
  }
}

class _TimeBottomPopState extends State<TimeBottomPop>{


  int ontaptime = 0;
  bool isontap = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery
        .of(context)
        .size;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle:true,
        title: Container(
          child: Text('选择日期',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black
            ),
          ),
        ),
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),
        bottom: PreferredSize(
            child: Container(
              margin: EdgeInsets.only(bottom: 3),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: _media.width / 7,
                    child: Text(
                      '日',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: _media.width / 7,
                    child: Text(
                      '一',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: _media.width / 7,
                    child: Text(
                      '二',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: _media.width / 7,
                    child: Text(
                      '三',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: _media.width / 7,
                    child: Text(
                      '四',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: _media.width / 7,
                    child: Text(
                      '五',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: _media.width / 7,
                    child: Text(
                      '六',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15
                      ),
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(20)),

      ),
      body: Container(
        height: 400,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 30.0,
                maxHeight: 30.0,
                child: Container(
                  height: 10,
                  color: Colors.red,
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context,int index){
                      return Calendar(
                          initTime: DateTime.now(),
                          firstTime: DateTime.now(),
                          endTime: DateTime.now(),
                      );
                    },
                  childCount: 1
                )
            )
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {

  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}