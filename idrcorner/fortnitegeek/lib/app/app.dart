import 'package:flutter/material.dart';

import 'package:fortnitegeek/app/login_page.dart';
import 'package:fortnitegeek/app/register_page.dart';
import 'package:fortnitegeek/app/admin_page.dart';
import 'package:fortnitegeek/app/user_page.dart';

class FortniteGeekApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Fortnite Geek App',
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CustomRoute(builder: (_) => LoginPage(), settings: settings);
          case '/register':
            return CustomRoute(builder: (_) => RegisterPage(), settings: settings);
        }
      },
      theme: ThemeData(
        primaryColor: Color(0xffc107a2),
        accentColor: Color(0xffed4bd2),
        dialogBackgroundColor: Colors.yellow
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomRoute<T> extends MaterialPageRoute<List<dynamic>> {
  CustomRoute(
      {@required WidgetBuilder builder, @required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) {
      return child;
    }

    return child;
  }
}
