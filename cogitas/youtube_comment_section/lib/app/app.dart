import 'package:flutter/material.dart';

import 'package:youtube_comment_section/app/home_page.dart';

class YoutubeCommentSectionApp extends StatelessWidget {
  final List comments;

  YoutubeCommentSectionApp({@required this.comments});
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Youtube Comment Section App',
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.redAccent
        ),
        home: HomePage(data: comments),
        debugShowCheckedModeBanner: false,
      );
    }
}