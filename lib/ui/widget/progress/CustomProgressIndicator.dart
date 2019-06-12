import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CustomProgressIndicator{

  static HeartBeat(_medal){
   return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: _medal.height * 0.4),
      child: Column(
          children: <Widget>[
            HeartbeatProgressIndicator(
              child: Icon(
                Icons.favorite,
                color: Colors.redAccent,
                size: 30,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: JumpingText(
                  'Loading...'
              ),
            )
          ]
      ),
    );
  }
}