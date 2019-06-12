import 'package:flutter/material.dart';
import 'package:hotel/common/constant.dart';
import 'package:hotel/config/application.dart';
import 'package:hotel/route/routes.dart';
import 'package:hotel/ui/widget/progress/progressdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonPage extends StatefulWidget {

  bool islogin = false;
  PersonPage({@required this.islogin = false});
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {

  double _imageHeight = 256.0;
  bool _loading = false;
  String username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStorageString(USER_NAME);
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return ProgressDialog(
        loading: _loading,
        child: Scaffold(
          body: new Stack(
            children: <Widget>[
              _mainbody()
            ],
          ),
        )
    );
  }

  Future deleteStorageString(key) async {
    print("delete");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
  }

  Widget _mainbody() {

    final _media = MediaQuery.of(context).size;
    double _index = 65;

    return CustomScrollView(

      controller: ScrollController(),
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Add new entry',
              onPressed: () {
                Application.navigateTo(context: context, route: '${Routes.settingpage}');
              },
            ),
          ],
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          expandedHeight: _imageHeight,
          flexibleSpace: FlexibleSpaceBar(
              background: new Scaffold(
                body: new Stack(
                  children: <Widget>[
                    _bulidImage(_index),
                    _buildProfileRow()
                  ],
                ),
              )),
          // floating: floating,
          // snap: snap,
          // pinned: pinned,
        ),
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: _media.width*0.95,
                child: Row(
                  children: <Widget>[
                    _showitem(Icons.color_lens,'收藏',_media),
                    _showitem(Icons.comment,'评价',_media),
                    _showitem(Icons.credit_card,'卡劵',_media),
                    _showitem(Icons.message,'消息',_media)
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white
                ),
              ),
              Container(
                height: 200,
                width: _media.width*0.95,
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    _showitem(Icons.local_activity,'会员卡',_media),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.amberAccent.withAlpha(200)
                ),
              ),
              Container(
                height: 500,
                width: _media.width*0.95,
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[

                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white
                ),
              )
            ],
          ),
        )

      ],
    );
  }

  _showitem(icon,msg,_media){
    return Container(
      width: _media.width*0.23,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 10,top: 20),
              child: Icon(
                icon,
                size: 30,
              )
          ),
          Padding(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Text(
                msg
            ),
          )
        ],
      ),
    );
  }

  Future getStorageString(key) async {
    setState(() {
      _loading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.get(key);
      _loading = false;
    });
  }

  ///APPBAR的背景图片及其剪裁
  Widget _bulidImage(double index) {
    return new ClipPath(
      //clipper: CustomRect(index),
        child: Container(
          height: 250,
          color: Colors.grey,
        )
    );
  }

  ///用户头像及其附属信息
  Widget _buildProfileRow() {
    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  username??"",
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                new Row(
                  children: <Widget>[
                    new Text(
                      'Product designer',
                      style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
