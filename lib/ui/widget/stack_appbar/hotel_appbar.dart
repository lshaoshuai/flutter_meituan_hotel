import 'package:flutter/material.dart';
import '../../widget/MyDivider.dart';

class HotelAppBar extends StatefulWidget {

  final Key key;
  final double height;
  final String hotelTitle;
  final HotelBarController controller;
  final GestureTapCallback onMenuTap;
  final GestureTapCallback onMessageTap;

  HotelAppBar({

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
    return HotelAppBarState();
  }
}

class HotelAppBarState extends State<HotelAppBar> {

  HotelBarController _controller;

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
                    color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(255 - _controller.value.alpha) : Colors.black.withAlpha(_controller.value.alpha),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                widget.hotelTitle,
                style: TextStyle(
                    color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(0) : Colors.black.withAlpha(_controller.value.alpha),
                    fontSize: _media.width / 20
                ),
              ),
            ),
            GestureDetector(
                onTap: widget.onMessageTap==null?(){}: widget.onMessageTap,
                child: new InkWell(
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.share,
                        size: _media.width / 18,
                        color: _controller.value.alpha < 255/2 ? Colors.white.withAlpha(255 - _controller.value.alpha) : Colors.black.withAlpha(_controller.value.alpha),
                      ),
                    )
                )
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (widget.controller == null) {
      _controller = new HotelBarController();
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
class HotelBarController extends ValueNotifier<HotelAlphaValue> {
  HotelBarController() :super(new HotelAlphaValue());
}

class HotelAlphaValue {
  int alpha;
}
