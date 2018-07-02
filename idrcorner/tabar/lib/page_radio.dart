import 'package:flutter/material.dart';

class Radio extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Container(
        child: new Column(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Text("Radio", style: new TextStyle(fontSize: 30.0)),
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Image.network('https://brain-images-ssl.cdn.dixons.com/5/6/10115665/u_10115665.jpg', width: 200.0, height: 200.0)
          ],
        ),
      );
    }
}