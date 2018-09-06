import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map data;

  DetailPage({@required this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Detail'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: 'Application name',
                    style: TextStyle(color: Colors.grey)),
                TextSpan(text: ': '),
                TextSpan(
                    text: data['app_name'],
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 11.0)),
              ]),
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: 'Category', style: TextStyle(color: Colors.grey)),
                TextSpan(text: ': '),
                TextSpan(
                    text: data['type'],
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 11.0)),
              ]),
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: 'Time Estimated',
                    style: TextStyle(color: Colors.grey)),
                TextSpan(text: ': '),
                TextSpan(
                    text: data['estimated_time'],
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 11.0)),
              ]),
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: 'Technology Used',
                    style: TextStyle(color: Colors.grey)),
                TextSpan(text: ': '),
                TextSpan(
                    text: data['technology'],
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 11.0)),
              ]),
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: 'Description', style: TextStyle(color: Colors.grey)),
                TextSpan(text: ': '),
                TextSpan(
                    text: data['description'],
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 11.0)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
