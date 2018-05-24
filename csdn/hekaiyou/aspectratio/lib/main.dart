import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Aspect Ratio',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Aspect Ratio'),
        ),
        body: new AspectRatio(
          aspectRatio: 5.0/7.0,
          child: new Container(
            decoration: new BoxDecoration(
              color: Colors.amber.withGreen(67)
            ),
          ),
        ),
      ),
    )
  );
}