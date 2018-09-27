import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        onPressed: () {
          print('hello there');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: <Widget>[
            PostedItem(),
            PostedItem(),
            PostedItem(),
            PostedItem(),
            PostedItem(),
          ],
        ),
      ),
    );
  }
}

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
                  top: 8.0, left: 40.0, bottom: 8.0, right: 8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
                  border: Border.all(width: 2.5, color: Theme.of(context).primaryColor)),
              child: Text('Cat is never full.'),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Theme.of(context).primaryColor),
                  color: Colors.red,
                  shape: BoxShape.circle),
              child: Center(child: Text('A')),
            ),
          ],
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 10.0,
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.thumb_up, size: 10.0),
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    '2 Likes',
                    style: TextStyle(
                      fontSize: 10.0
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
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.thumb_up, size: 10.0),
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    '2 Likes',
                    style: TextStyle(fontSize: 10.0),
                  )
                ],
              ),
              SizedBox(width: 5.0),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 10.0,
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.thumb_up, size: 10.0),
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    '2 Likes',
                    style: TextStyle(fontSize: 10.0),
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
