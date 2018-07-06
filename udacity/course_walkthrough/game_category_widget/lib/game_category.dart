import 'package:flutter/material.dart';

class GameCategory extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Container(
        height: 80.0,
        margin: const EdgeInsets.all(20.0),
        child: new Material(
          color: Colors.transparent,
          child: new InkWell(
            splashColor: Colors.redAccent,
            borderRadius: BorderRadius.circular(50.0),
            onTap: () => print('tapped'),
            child: new Center(
              child: new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.games,
                      size: 40.0,
                    ),
                    new Padding(padding: const EdgeInsets.only(right: 10.0)),
                    new Text(
                      'PUBG Mobile',
                      style: new TextStyle(
                        fontSize: 20.0
                      ),
                    )
                  ],
                )
              )
            )
          ),
        )
      );
    }
}