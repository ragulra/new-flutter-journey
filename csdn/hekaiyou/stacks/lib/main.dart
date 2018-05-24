import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Youming Meme',
      home: new YoumingMeme(),
    )
  );
}

class YoumingMeme extends StatefulWidget {
  @override
    YoumingMemeState createState() {
      // TODO: implement createState
      return new YoumingMemeState();
    }
}

class YoumingMemeState extends State<YoumingMeme> {
  bool _isLoading = false;

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Yaoming Meme'),
          centerTitle: true,
        ),
        body: new Center(
          child: new Stack(
            children: <Widget>[
              new Image.asset(
                'assets/yaoming.jpg'
              ),
              new Positioned(
                bottom: 0.0,
                child: new Text(
                  'When you hear someone talk about you',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  ),
                ),
              )
            ],
          )
        )
      );
    }
}