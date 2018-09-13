import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:youtube_comment_section/app/app.dart';

void main() {
  loadComments().then((comments) {
    runApp(YoutubeCommentSectionApp(comments: comments));
  });
}

Future<String> loadComments() async {
  var response = await http.get('https://jsonplaceholder.typicode.com/comments');

  return response.body;
}
