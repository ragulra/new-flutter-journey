import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Oppacity',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Opacity'),
        ),
        body: new SizedBox.expand(
          child: new Opacity(
            opacity: 0.9,
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.cyan.withRed(100)
              ),
            ),
          ),
        )
      ),
    )
  );
}