import 'package:flutter/material.dart';

class PlaceholderContent extends StatelessWidget {
  final String title;
  final String message;
  final ValueChanged<bool> tryAgainButton;

  PlaceholderContent({this.title, this.message, this.tryAgainButton});

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white70
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              title,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white70
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                child: Text(
                  'Try Again',
                  textDirection: TextDirection.ltr,
                ),
                onPressed: () => tryAgainButton(true),
              ),
            )
          ],
        ),
      );
    }
}