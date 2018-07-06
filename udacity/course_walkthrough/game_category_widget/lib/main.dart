/* GAME CATEGORY */
import 'package:flutter/material.dart';
import 'game_category.dart';

void main() {
  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Category Widget',
      home: new Home(),
    )
  );
}

class Home extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        backgroundColor: Colors.teal,
        body: new Center(
          child: new GameCategory()
        ),
      );
    }
}