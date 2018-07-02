import 'package:flutter/material.dart';

void main() =>  runApp(new MyApp());

final ThemeData themeData = ThemeData(
  canvasColor: Colors.lightGreenAccent
);

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Center(
          child: FlatButton(
            onPressed: () {
              Navigator.push(context, PageTwo());
            },
            child: Text('Go to Page Two'),
          ),
        ),
      );
    }
}

class PageTwo extends MaterialPageRoute<Null> {
  PageTwo() : super(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 1.0,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(context, PageThree());
          },
          child: Text('Go to Page Three'),
        ),
      ),
    );
  });
}

class PageThree extends MaterialPageRoute<Null> {
  PageThree() : super(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Last Page'),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  });
}