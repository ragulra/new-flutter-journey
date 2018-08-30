import 'package:flutter/material.dart';

import 'package:googlelikecalc/app/home_page.dart';

class GoogleLikeCalcApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Google Like Calc App',
        theme: ThemeData(
          primaryColor: Colors.lightGreen,
          accentColor: Colors.lightGreenAccent
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      );
    }
}