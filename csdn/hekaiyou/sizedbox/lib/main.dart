import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'SizedBox',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('SizedBox'),
          centerTitle: true,
        ),
        body: new SizedBox(
          width: 250.0,
          height: 250.0,
          child: new Container(
            decoration: new BoxDecoration(
              color: Colors.green.withBlue(222)
            ),
          ),
        ),
      ),
    )
  );
}