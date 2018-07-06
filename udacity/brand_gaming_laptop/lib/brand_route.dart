import 'package:flutter/material.dart';

import 'brand.dart';

final _backgroundColor = Colors.teal[200];

class BrandRoute extends StatelessWidget {
  const BrandRoute();

  static const _brandNames = <String>[
    'Asus',
    'Lenovo',
    'MSI',
    'LG',
    'Compact',
    'Dell',
    'Apple',
    'Sony',
  ];

  static const _baseColor = <Color>[
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.purple,
    Colors.amber,
    Colors.pink,
    Colors.lime
  ];

  Widget _buildBrandWidget(List<Widget> brands) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => brands[index],
      itemCount: brands.length,
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      final brands = <Brand>[];

      for (var i = 0; i < _brandNames.length; i++) {
        brands.add(Brand(
          name: _brandNames[i],
          color: _baseColor[i],
          icon: Icons.computer,
        ));
      }

      final listView = new Container(
        color: _backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: _buildBrandWidget(brands),
      );

      final appBar = new AppBar(
        elevation: 0.0,
        title: new Text(
          'Brand Gaming Laptop',
          style: new TextStyle(
            color: Colors.black,
            fontSize: 30.0
          ),
        ),
        centerTitle: true,
        backgroundColor: _backgroundColor,
      );

      return new Scaffold(
        appBar: appBar,
        body: listView,
      );
    }
}