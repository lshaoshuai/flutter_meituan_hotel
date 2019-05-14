import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class PersonPage extends StatefulWidget {

  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  double _imageHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          _mainbody()
        ],
      ),
    );
  }

  Widget _mainbody() {

    double _index = 65;

    return CustomScrollView(

      controller: ScrollController(),
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              tooltip: 'Add new entry',
              onPressed: () {
                print('add');
                /* ... */
              },
            ),
          ],
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          expandedHeight: _imageHeight,
          flexibleSpace: FlexibleSpaceBar(
              background: new Scaffold(
                body: new Stack(
                  children: <Widget>[_bulidImage(_index), _buildProfileRow()],
                ),
              )),
          // floating: floating,
          // snap: snap,
          // pinned: pinned,
        ),

        SliverFixedExtentList(
          itemExtent: 200.0,
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 50,
            ),
            Card(
              color: Colors.amber,
            ),
            Card(
              color: Colors.amber,
            ),
            Card(
              color: Colors.amber,
            )
          ]),
        ),
      ],
    );
  }

  ///APPBAR的背景图片及其剪裁
  Widget _bulidImage(double index) {
    return new ClipPath(
      //clipper: CustomRect(index),
        child: Image.network(
          "https://img4.duitang.com/uploads/item/201402/14/20140214120558_2f4NN.jpeg",
          fit: BoxFit.fill,
          height: 256.0,
          colorBlendMode: BlendMode.srcOver,
          color: new Color.fromARGB(120, 20, 10, 40),
        ));
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
                  'Ryan Barnes',
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
