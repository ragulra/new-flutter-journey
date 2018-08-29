import 'package:flutter/material.dart';

import 'package:random_wallpaper/home_page.dart';

class RandomWallpaperApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Random Wallpaper',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark()
      );
    }
}