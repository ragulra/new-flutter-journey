import 'package:flutter/material.dart';

import 'package:mind_blowing_fact/app/home_page.dart';
import 'package:mind_blowing_fact/app/login_page.dart';

class MindBlowingFactApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Mind Blowing Fact App',
        theme: ThemeData(
          primaryColor: Colors.teal,
          accentColor: Color(0xfff0e68c),
        ),
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      );
    }
}