import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Linear Gradient Color',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Linear Gradient'),
        ),
        body: new AspectRatio(
          aspectRatio: 3.0/2.0,
          child: new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  new Color(0xff223ad1),
                  new Color(0xffaaf921),
                  new Color(0xff0fa291),
                ],
                begin: new FractionalOffset(1.0, 0.0),
                end: new FractionalOffset(1.0, 1.0),
              )
            ),
            child: new Center(
              child: new Text(
                'Linear Gradient',
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),
            )
          ),
        )
      ),
    )
  );
}