import 'package:flutter/material.dart';
import '../../widget/MyDivider.dart';

class CustomTitleBar extends StatefulWidget {
  final Key key;
  final double height;
  final CustomTitleBarController controller;
  final GestureTapCallback onMenuTap;
  final GestureTapCallback onMessageTap;

  CustomTitleBar({
    this.onMenuTap,
    this.onMessageTap,
    this.controller,
    this.height: 65.0,
    this.key
  }) :super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CustomTitleBarState();
  }
}

class CustomTitleBarState extends State<CustomTitleBar> {

  CustomTitleBarController _controller;

  Widget _buildText(context){

    final _media = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.only(left: _media.width * 0.38,top: 15),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.four_k,
                color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(255 - _controller.value.alpha) : Colors.red.withAlpha(_controller.value.alpha),
              ),
            ),
            Semantics(
              child: Text('边度酒店',
                style: TextStyle(
                  fontSize: 20,
                  color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(255 - _controller.value.alpha) :Colors.black.withAlpha(_controller.value.alpha),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        )
    );

  }

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
            _buildText(context),
            new GestureDetector(
              onTap: widget.onMessageTap==null?(){}: widget.onMessageTap,
              child: new InkWell(
                child: Container(
                  padding: EdgeInsets.only(left: 10,top: 15),
                  child: new Icon(
                    Icons.cloud,
                    color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(255 - _controller.value.alpha) : Colors.red.withAlpha(_controller.value.alpha),
                  ),
                ),
              ),
            ),
            new GestureDetector(
              onTap: widget.onMessageTap==null?(){}: widget.onMessageTap,
              child: new InkWell(
                child: Container(
                  padding: EdgeInsets.only(top: 15,right: 15),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.notifications,
                        color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(255 - _controller.value.alpha) : Colors.red.withAlpha(_controller.value.alpha),
                      ),
                      Text(
                        '客服',
                        style: TextStyle(
                          fontSize: 10,
                            color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(255 - _controller.value.alpha) : Colors.red.withAlpha(_controller.value.alpha)
                        ),
                      )
                    ],
                  )
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
      _controller = new CustomTitleBarController();
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
class CustomTitleBarController extends ValueNotifier<ContomTitleAlphaValue> {
  CustomTitleBarController() :super(new ContomTitleAlphaValue());
}

class ContomTitleAlphaValue {
  int alpha;
}
