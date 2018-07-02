import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      home: new PageOne(),
      title: "Navigasi",
      routes: <String, WidgetBuilder> {
        '/PageOne': (BuildContext context) => new PageOne(),
        '/PageTwo': (BuildContext context) => new PageTwo()
      },
    )
  );
}

class PageOne extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Music'),
        ),
        body: new Center(
          child: new IconButton(
            icon: new Icon(Icons.headset, size: 50.0),
            onPressed: () {
              Navigator.pushNamed(context, '/PageTwo');
            }
          ),
        ),
      );
    }
}

class PageTwo extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('HDR Weak'),
        ),
        body: new Center(
          child: new IconButton(
            icon: new Icon(Icons.hdr_weak, size: 50.0),
            onPressed: () {
              Navigator.pushNamed(context, '/PageOne');
            }
          ),
        ),
      );
    }
}