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
        backgroundColor: Colors.purple,
        elevation: 0.0,
        onPressed: () {
          print('hello there');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple,
        child: ButtonBar(
          children: <Widget>[],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: <Widget>[
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
                  border: Border.all(width: 2.5)),
              child: Text('Cat is never full.'),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0),
                  color: Colors.red,
                  shape: BoxShape.circle),
              child: Center(child: Text('A')),
            )
          ],
        ),
        SizedBox(height: 10.0)
      ],
    );
  }
}
