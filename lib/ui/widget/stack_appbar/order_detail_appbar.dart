import 'package:flutter/material.dart';
import 'package:hotel/common/constant.dart';
import '../../widget/MyDivider.dart';

class OrderDetailAppBar extends StatefulWidget {

  final Key key;
  final double height;
  final String hotelTitle;
  final OrderDetailBarController controller;
  final GestureTapCallback onMenuTap;
  final GestureTapCallback onMessageTap;

  OrderDetailAppBar({

    this.onMenuTap,
    this.onMessageTap,
    this.controller,
    this.height: 65.0,
    this.key,
    this.hotelTitle

  }) :super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderDetailAppBarState();
  }
}

class OrderDetailAppBarState extends State<OrderDetailAppBar> {

  OrderDetailBarController _controller;

  _buildTitle(context) {

    final _media = MediaQuery.of(context).size;

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
          color: Colors.white.withAlpha(_controller.value.alpha),
          border: Border(
              bottom: BorderSide(
                  color: Colors.black,
                  width: 0.1,
                  style: _controller.value.alpha < 255/2 ? BorderStyle.none :BorderStyle.solid
              )
          )
      ),
      child: new Padding(
        padding: new EdgeInsets.only(top: 25.0),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: new InkWell(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: new Icon(
                    Icons.arrow_back_ios,
                    size: _media.width / 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.hotelTitle,
                style: TextStyle(
                    fontFamily: fontname,
                    color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(0) : Colors.black.withAlpha(_controller.value.alpha)
                ),
              ),
            ),
            new GestureDetector(
              onTap: widget.onMessageTap==null?(){}: widget.onMessageTap,
              child: new InkWell(
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    child:Icon(
                      Icons.share,
                      size: _media.width / 18,
                      color: Colors.black,
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (widget.controller == null) {
      _controller = new OrderDetailBarController();
      _controller.value.alpha = 0;
    } else {
      _controller = widget.controller;
    }
    return _buildTitle(context);
  }
}

/// A [ChangeNotifier] that holds a single value.
///
/// When [value] is replaced with something that is not equal to the old
/// value as evaluated by the equality operator ==, this class notifies its
/// listeners.
class OrderDetailBarController extends ValueNotifier<AlphaValue> {
  OrderDetailBarController() :super(new AlphaValue());
}

class AlphaValue {
  int alpha;
}
