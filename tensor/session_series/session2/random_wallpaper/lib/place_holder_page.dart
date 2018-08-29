import 'package:flutter/material.dart';

class PlaceHolderPage extends StatelessWidget {
  final String title;
  final String message;
  final ValueChanged<bool> tryAgainButton;

  PlaceHolderPage({this.title, this.message, this.tryAgainButton});

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
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: TextStyle(fontSize: 16.0, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 12.0,
              ),
              child: Text(
                'Try Again',
              ),
              onPressed: () => tryAgainButton(true),
            ),
          )
        ],
      ),
    );
  }
}
