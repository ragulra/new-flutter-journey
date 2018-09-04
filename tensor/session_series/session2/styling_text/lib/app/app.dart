import 'package:flutter/material.dart';

import 'package:styling_text/app/home_page.dart';

class StylingTextApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Styling Text App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xfff47142),
          accentColor: Color(0xfff4a641)),
    );
  }
}
