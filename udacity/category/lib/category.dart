import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color color;

  Category({this.text, this.iconData, this.color});

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(50.0)
        ),
        height: 100.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Material(
          animationDuration: new Duration(milliseconds: 200),
          shadowColor: Colors.transparent,
          borderRadius: new BorderRadius.circular(50.0),
          color: Colors.transparent,
          child: new InkWell(
            splashFactory: InkSplash.splashFactory,
            splashColor: color,
            onTap: () => print('pressed'),
            child: new Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[
                  new Icon(
                    iconData,
                    size: 25.0,
                  ),
                  new Padding(padding: const EdgeInsets.only(right: 20.0)),
                  new Text(
                    text,
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700
                    ),
                  )
                ],
              ),
            )
          ),
        )
      );
    }
}