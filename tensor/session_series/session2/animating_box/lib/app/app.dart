import 'package:flutter/material.dart';

import 'package:animating_box/app/home_page.dart';

class AnimatingBoxApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Animating Box App',
        home: HomePage(),
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
      );
    }
}