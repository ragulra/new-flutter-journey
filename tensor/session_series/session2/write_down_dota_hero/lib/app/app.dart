import 'package:flutter/material.dart';

import 'package:write_down_dota_hero/app/page/home.dart';

class WriteDownDotaHeroApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Write Down Dota Hero',
        theme: ThemeData.dark(),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      );
    }
}