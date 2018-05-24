import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Tony tony chopper',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Tony tony chopper'),
        ),
        body: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: new Image(
            image: new AssetImage(
              'assets/chopper.png'
            ),
          ),
        ),
      ),
    )
  );
}