import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      home: new TextControl(),
    )
  );
}

class TextControl extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Text common control'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Luffy (Captain)',
                style: new TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  fontSize: 15.0,
                  color: Colors.red
                ),
              ),
              new Text(
                'Zoro (Right-hand Luffy)',
                style: new TextStyle(
                  fontFamily: 'Comic Sans MS',
                  color: Colors.green,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.red,
                  fontSize: 15.0
                ),
              ),
              new Text(
                'Sanji (Chef)',
                style: new TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.red,
                  fontSize: 15.0,
                  color: Colors.yellow
                ),
              ),
              new Text(
                'Nami (Navigator)',
                style: new TextStyle(
                  decoration: TextDecoration.overline,
                  decorationColor: Colors.red,
                  fontSize: 15.0,
                  color: Colors.orange
                ),
              ),
              new Text(
                'Ussop (Snipper)',
                style: new TextStyle(
                  fontFamily: 'sans-serif',
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                  color: Colors.brown               
                ),
              ),
              new Text(
                'Chopper (Unknown)',
                style: new TextStyle(
                  fontFamily: 'serif',
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                  color: Colors.pink
                ),
              ),
              new Text(
                'Robin (Arceolog)',
                style: new TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  fontSize: 15.0,
                  color: Colors.purple
                ),
              ),
              new Text(
                'Brook (Musician)',
                style: new TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  fontSize: 15.0,
                  color: Colors.grey
                ),
              ),
              new Text(
                'Franky (Ship Worker)',
                style: new TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  fontSize: 15.0,
                  color: Colors.lightBlue
                ),
              ),
              new Text(
                'Jinbei (Unknown)',
                style: new TextStyle(
                  fontFamily: 'Times New Roman',
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  fontSize: 15.0,
                  color: Colors.blueGrey
                ),
              ),
            ],
          ),
        )
      );
    }
}