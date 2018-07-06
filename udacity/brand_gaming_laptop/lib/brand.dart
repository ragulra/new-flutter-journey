import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class Brand extends StatelessWidget {
  final String name;
  final ColorSwatch color;
  final IconData icon;

  const Brand({
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
            onTap: () => print('akimilaku'),
            borderRadius: _borderRadius,
            highlightColor: color,
            splashColor: color,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: new Icon(
                      icon,
                      size: 60.0
                    ),
                  ),
                  new Center(
                    child: new Text(
                      name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
}