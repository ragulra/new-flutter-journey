import 'package:flutter/material.dart';

import 'model/product.dart';
import 'backdrop.dart';
import 'supplemental/cut_corner_borders.dart';
import 'colors.dart';
import 'home.dart';
import 'login.dart';
import 'category_menu_page.dart';

final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kShrineBrown900,
    primaryColor: kShrinePink100,
    buttonColor: kShrinePink100,
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(
      color: kShrineBrown900
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder()
    )
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500
    ),
    title: base.title.copyWith(
      fontSize: 18.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0
    ),
  ).apply(
    fontFamily: 'Rubick',
    displayColor: kShrineBrown900,
    bodyColor: kShrineBrown900
  );
}

class ShrineApp extends StatefulWidget {
  @override
    _ShrineAppState createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
    Category _currentCategory = Category.all;

    void _onCategoryTap(Category category) {
      setState(() {
        _currentCategory = category;
      });
    }
    Route<dynamic> _getRoute(RouteSettings settings) {
      if (settings.name != '/login') {
        return null;
      }

      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => LoginPage(),
        fullscreenDialog: true
      );
    }

    @override
      Widget build(BuildContext context) {
        // TODO: implement build
        return MaterialApp(
          title: 'Shrine',
          // home: HomePage(),
          home: Backdrop(
            currentCategory: _currentCategory,
            frontLayer: HomePage(category: _currentCategory),
            backLayer: CategoryMenuPage(
              currentCategory: _currentCategory,
              onCategoryTap: _onCategoryTap,
            ),
            frontTitle: Text('SHRINE'),
            backTitle: Text('MENU'),
          ),
          initialRoute: '/login',
          onGenerateRoute: _getRoute,
          theme: _kShrineTheme,
        );
      }
}