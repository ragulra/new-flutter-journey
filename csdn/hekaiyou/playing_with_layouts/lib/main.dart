import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      home: new LayoutSample(),
    )
  );
}

class LayoutSample extends StatefulWidget {
  @override
    LayoutSampleState createState() {
      // TODO: implement createState
      return new LayoutSampleState();
    }
}

class LayoutSampleState extends State<LayoutSample> {
  bool isRowLayout = false;

  void _changeLayout() {
    setState(() {
      if (!isRowLayout) {
        isRowLayout = true;
      } else {
        isRowLayout = false;
      }
    });
  }

  Widget rowLayout = new Row(
    children: <Widget>[
      new RaisedButton(
        onPressed: () {
          print('button yellow');
        },
        color: Colors.yellow,
        child: new Text('Yellow'),
      ),
      new Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: new RaisedButton(
          onPressed: () {
            print('button red');
          },
          color: Colors.red,
          child: new Text('red'),
        ),
      ),
      new RaisedButton(
        onPressed: () {
          print('button blue');
        },
        color: Colors.blue,
        child: new Text('blue'),
      ),
    ],
  );

  Widget columnLayout = new Column(
    children: <Widget>[
      new RaisedButton(
        onPressed: () {
          print('button yellow');
        },
        color: Colors.yellow,
        child: new Text('Yellow'),
      ),
      new Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: new RaisedButton(
          onPressed: () {
            print('button red');
          },
          color: Colors.red,
          child: new Text('red'),
        ),
      ),
      new RaisedButton(
        onPressed: () {
          print('button blue');
        },
        color: Colors.blue,
        child: new Text('blue'),
      ),
    ],
  );

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Layout Samples'),
        ),
        body: isRowLayout ? rowLayout : columnLayout,
        floatingActionButton: new FloatingActionButton(
          onPressed: _changeLayout,
          child: new Icon(
            Icons.cached
          ),
        ),
      );
    }
}