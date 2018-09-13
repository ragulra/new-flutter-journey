import 'dart:async';
import 'dart:convert';

import 'package:youtube_comment_section/app/comment.class.dart';

List<Comment> parseCommentToClass(String jsondata) {
  List decoded = json.decode(jsondata);

  List<Comment> comments = List<Comment>();
  for(var comment in decoded) {
    comments.add(
      Comment(
        postId: comment['postId'],
        id: comment['id'],
        email: comment['email'],
        name: comment['name'],
        comment: comment['body']
      )
    );
  }

  return comments;
}

Future<List<Comment>> loadComments(String datacomment) async {
  List<Comment> comments = parseCommentToClass(datacomment);
  return comments;
}