import 'package:flutter/material.dart';

import 'package:taptapscreen/app/home.page.dart';

class TapTapScreenApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Tap Tap Screen App',
        theme: ThemeData(
          primaryColor: Colors.yellow,
          accentColor: Colors.yellowAccent
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      );
    }
}