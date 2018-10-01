import 'package:flutter/material.dart';

class PostedItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int alikes;
  final int adislikes;
  final int acomments;
  final String fact;

  PostedItem({
    @required this.name,
    @required this.imageUrl,
    @required this.alikes,
    @required this.adislikes,
    @required this.acomments,
    @required this.fact,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
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
                fact,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(imageUrl),
            )
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
                    alikes.toString() + ' likes',
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
                    adislikes.toString() + ' dislikes',
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
                    acomments.toString() + ' comments',
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
      ],
    );
  }
}
