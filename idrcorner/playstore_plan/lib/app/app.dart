import 'package:flutter/material.dart';

import 'package:playstore_plan/app/home_page.dart';

class PlaystorePlanApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Playstore App Plan',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData.dark(),
      );
    }
}