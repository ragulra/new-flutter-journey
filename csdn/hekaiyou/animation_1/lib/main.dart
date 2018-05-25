import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    new MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new MaterialApp(
        title: 'Advanced Animation',
        home: new MyHomePage(),
      );
    }
}

class MyHomePage extends StatefulWidget {
  @override
    MyHomePageState createState() {
      // TODO: implement createState
      return new MyHomePageState();
    }
}

class MyHomePageState extends State<MyHomePage> {
  int dataSet;

  void changeData() {
    setState(() {
      dataSet = new Random().nextInt(100);
    });
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        body: new Center(
          child: new Text('Value: $dataSet'),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: changeData,
          child: new Icon(Icons.refresh),
        ),
      );
    }
}
