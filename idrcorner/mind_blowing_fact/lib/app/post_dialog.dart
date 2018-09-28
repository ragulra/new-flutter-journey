import 'package:flutter/material.dart';

class PostDialog extends StatelessWidget {
  final TextEditingController controller;
  final Function onFactPosted;

  PostDialog({
    @required this.controller,
    @required this.onFactPosted,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SimpleDialog(
      title: Text('Post a Fact'),
      contentPadding: EdgeInsets.all(8.0),
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  labelText: 'Fact',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)))),
        ),
        SizedBox(height: 5.0),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 0.0,
          color: Theme.of(context).primaryColor,
          disabledColor: Theme.of(context).accentColor,
          highlightColor: Colors.redAccent,
          onPressed: () => onFactPosted,
          child: Text(
            'Share',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        )
      ],
    );
  }
}
