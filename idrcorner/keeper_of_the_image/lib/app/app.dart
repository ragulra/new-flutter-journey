import 'package:flutter/material.dart';

import 'package:keeper_of_the_image/app/home_page.dart';

class KeeperOfTheImageApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Keeper of the Image',
        home: HomePage(),
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
          accentColor: Colors.lightBlueAccent
        ),
        debugShowCheckedModeBanner: false,
      );
    }
}