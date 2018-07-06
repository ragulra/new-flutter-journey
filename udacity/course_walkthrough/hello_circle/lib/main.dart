import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Hello Circle',
      theme: new ThemeData(
        primarySwatch: Colors.cyan
      ),
      home: new HelloCircle(),
    )
  );
}

class HelloCircle extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Tap the Circle'),
        ),
        body: new Container(
          child: new Center(
            child: new Card(
              child: new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Material(
                  color: Colors.transparent,
                  child: new InkWell(
                    onTap: () {
                      print('Wkwkwkwk');
                    },
                    borderRadius: BorderRadius.circular(100.0),
                    splashColor: Colors.cyan,
                    child: new CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 100.0,
                      child: new Text(
                        'Tap on Me',
                        style: new TextStyle(
                          color: Colors.red,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                    ),
                  ),
                )
              )
            ),
          ),
        ),
      );
    }
}