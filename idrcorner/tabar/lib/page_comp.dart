import 'package:flutter/material.dart';

class Computer extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Container(
        child: new Column(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Text("Computer", style: new TextStyle(fontSize: 30.0)),
            new Padding(padding: new EdgeInsets.all(20.0)),
            new Image.asset('assets/img/computer.jpeg')
          ],
        ),
      );
    }
}