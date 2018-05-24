import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Popup Menu',
      home: new PopupMenuExample(),
    )
  );
}

class PopupMenuExample extends StatefulWidget {
  @override
    PopupMenuExampleState createState() {
      // TODO: implement createState
      return new PopupMenuExampleState();
    }
}

class PopupMenuExampleState extends State<PopupMenuExample> {
  String stringBody = 'Hello madafaka!';
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Popup Menu'),
          actions: <Widget>[
            new PopupMenuButton<String>(
              onSelected: (String value) {
                setState(() {
                  stringBody = value;
                });
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<String>>[
                  new PopupMenuItem<String>(
                    value: 'Again, madafaka!',
                    child: new Text('Just For You'),
                  ),
                  new PopupMenuItem<String>(
                    value: 'Im not madafaka!',
                    child: new Text('Just here pls'),
                  )
                ];
              },
            )
          ],
        ),
        body: new Center(
          child: new Text(stringBody),
        ),
      );
    }
}