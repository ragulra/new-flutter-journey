import 'package:flutter/material.dart';

class PostedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  top: 16.0, left: 50.0, bottom: 16.0, right: 16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
                  border: Border.all(
                      width: 2.5, color: Theme.of(context).primaryColor)),
              child: Text(
                'Cat is never full.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12.0
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0, color: Theme.of(context).primaryColor),
                  color: Colors.red,
                  shape: BoxShape.circle),
              child: Center(child: Text('A')),
            ),
          ],
        ),
        SizedBox(height: 2.0),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 10.0,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.thumb_up, size: 10.0),
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    '2 likes',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'JosefinSans',
                    ),
                  )
                ],
              ),
              SizedBox(width: 5.0),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 10.0,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.thumb_down, size: 10.0),
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    '2 dislikes',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'JosefinSans',
                    ),
                  )
                ],
              ),
              SizedBox(width: 5.0),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 10.0,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown,
                    child: Icon(Icons.comment, size: 10.0),
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    '2 comments',
                    style: TextStyle(
                      fontSize: 10.0, 
                      fontFamily: 'JosefinSans',
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0)
      ],
    );
  }
}