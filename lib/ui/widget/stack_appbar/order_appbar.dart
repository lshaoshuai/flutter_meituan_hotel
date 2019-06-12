import 'package:flutter/material.dart';
import '../../widget/MyDivider.dart';

class OrderAppBar extends StatefulWidget {

  final Key key;
  final double height;
  final OrderBarController controller;
  final GestureTapCallback onMenuTap;
  final GestureTapCallback onMessageTap;

  OrderAppBar({

    this.onMenuTap,
    this.onMessageTap,
    this.controller,
    this.height: 65.0,
    this.key,

  }) :super(key: key);

  @override
  OrderAppBarState createState () => new OrderAppBarState();

}

class OrderAppBarState extends State<OrderAppBar> {

  OrderBarController _controller;

  _buildTitle(context) {

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
                    Icons.arrow_back,
                    color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(255 - _controller.value.alpha) : Colors.black.withAlpha(_controller.value.alpha),
                  ),
                ),
              ),
            ),
            new GestureDetector(
              onTap: widget.onMessageTap==null?(){}: widget.onMessageTap,
              child: new InkWell(
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.share,
                      color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(255 - _controller.value.alpha) : Colors.black.withAlpha(_controller.value.alpha),
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
      _controller = new OrderBarController();
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
class OrderBarController extends ValueNotifier<AlphaValue> {
  OrderBarController() :super(new AlphaValue());
}

class AlphaValue {
  int alpha;
}
