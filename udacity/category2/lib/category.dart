import 'package:meta/meta.dart';

import 'package:flutter/material.dart';

import 'converter_route.dart';
import 'unit.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class Category extends StatelessWidget {
  final String name;
  final ColorSwatch color;
  final IconData icon;
  final List<Unit> units;

  const Category({
    Key key,
    @required this.name,
    @required this.color,
    @required this.icon,
    @required this.units
  }) : assert(name != null),
      assert(color != null),
      assert(icon != null),
      assert(units != null),
      super(key: key);

  /* 
    definisikan event click pada masing2 item
    yang content dan isinya dibuat dinamis berdasarkan angka 1 - 10
  */
  void _navigateToConverter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            title: Text(
              name,
              style: Theme.of(context).textTheme.display1,
            ),
            centerTitle: true,
            backgroundColor: color,
          ),
          body: ConverterRoute(
            color: color,
            name: name,
            units: units,
          ),
          resizeToAvoidBottomPadding: false,
        );
      }
    ));
  }

  /* buat animasi splash pada button */
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Material(
        color: Colors.transparent,
        child: Container(
          height: _rowHeight,
          child: InkWell(
            onTap: () => _navigateToConverter(context),
            borderRadius: _borderRadius,
            highlightColor: color['highlight'],
            splashColor: color['splash'],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      icon,
                      size: 60.0,
                    ),
                  ),
                  Center(
                    child: Text(
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