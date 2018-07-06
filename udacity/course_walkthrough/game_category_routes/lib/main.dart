/* DOTA 2 */
import 'package:flutter/material.dart';
import 'role.dart';

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
          child: new Role(
            name: 'PUBG Mobile',
            icon: Icons.gamepad,
            color: Colors.purple,
          )
        ),
      );
    }
}