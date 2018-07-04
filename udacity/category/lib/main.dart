import 'package:flutter/material.dart';

import 'category.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Category',
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          title: new Text('Category'),
        ),
        backgroundColor: Colors.lightGreenAccent,
        body: new ListView(
          children: <Widget>[
            new Category(
            text: 'Web Developer',
            color: Colors.red,
            iconData: Icons.computer,
          ),
          new Category(
            text: 'Web Developer',
            color: Colors.green,
            iconData: Icons.computer,
          ),
          new Category(
            text: 'Web Developer',
            color: Colors.blue,
            iconData: Icons.computer,
          ),
          new Category(
            text: 'Web Developer',
            color: Colors.yellow,
            iconData: Icons.computer,
          ),
          new Category(
            text: 'Web Developer',
            color: Colors.purple,
            iconData: Icons.computer,
          ),
          ],
        )
      ),
      debugShowCheckedModeBanner: false,
    )
  );
}