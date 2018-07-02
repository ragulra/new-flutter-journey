import 'package:flutter/material.dart';

class SmartPhone extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Container(
        child: new Column(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Text("Headset", style: new TextStyle(fontSize: 30.0)),
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Image.network('https://www.t-mobile.com/content/dam/t-mobile/en-p/cell-phones/apple/apple-iphone-x/silver/Apple-iPhoneX-Silver-1-3x.jpg', width: 200.0, height: 200.0)
          ],
        ),
      );
    }
}