import 'package:flutter/material.dart';

import 'brand_route.dart';

void main() {
  runApp(
    BrandGamingLaptop()
  );
}

class BrandGamingLaptop extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brand Gaming Laptop',
        home: BrandRoute(),
      );
    }
}