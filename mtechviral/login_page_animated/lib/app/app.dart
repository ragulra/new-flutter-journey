import 'package:flutter/material.dart';

import 'package:login_page_animated/app/login_page.dart';

class LoginPageAnimatedApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Login Page Animated App',
        theme: ThemeData(
          primaryColor: Color(0xff88ae31),
          accentColor: Color(0xff88ff31)
        ),
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      );
    }
}