import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      home: new ContainerControl(),
    )
  );
}

class ContainerControl extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Center(
        child: new Container(
          height: 128.0,
          width: 128.0,
          decoration: new BoxDecoration(
            color: Colors.green.withGreen(100),
            border: new Border.all(
              color: Colors.red,
              width: 2.0
            )
          ),
          child: new Center(
            child: new Text(
              'Center it!',
              textDirection: TextDirection.ltr,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      );
    }
}