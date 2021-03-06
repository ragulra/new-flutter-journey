import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class GameCategory extends StatelessWidget {
  final String name;
  final ColorSwatch color;
  final IconData icon;

  const GameCategory({
    Key key,
    @required this.name,
    @required this.color,
    @required this.icon
  }) : assert(name != null),
       assert(color != null),
       assert(icon != null),
       super(key: key);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Material(
        color: Colors.transparent,
        child: new Container(
          height: _rowHeight,
          child: new InkWell(
            splashColor: color,
            borderRadius: _borderRadius,
            highlightColor: color,
            onTap: () => print('tapped'),
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Padding(
                      padding: EdgeInsets.all(16.0),
                      child: new Icon(
                      Icons.games,
                      size: 40.0,
                    ),
                  ),
                  new Center(
                    child: new Text(
                      name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline
                    ),
                  )
                ],
              )
            )
          ),
        )
      );
    }
}