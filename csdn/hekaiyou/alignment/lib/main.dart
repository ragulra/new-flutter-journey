import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Align Control',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Align Control'),
        ),
        body: new AlignControl(),
      ),
    )
  );
}

class AlignControl extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Stack(
        children: <Widget>[
          new Align(
            alignment: new FractionalOffset(0.0, 0.0),
            child: new Image(
              image: new AssetImage('assets/shp.png'),
            ),
          ),
          new Align(
            alignment: FractionalOffset.center,
            child: new Text('VS',
              style: new TextStyle(
                fontSize: 40.0,
              )),
          ),
          new Align(
            alignment: FractionalOffset.bottomCenter,
            child: new Image(
              image: new AssetImage('assets/kaido.png'),
            ),
          )
        ],
      );
    }
}