import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.red
      ),
      home: new LuffyGear4(),
    )
  );
}

class LuffyGear4 extends StatefulWidget {
  @override
    LuffyGear4State createState() {
      // TODO: implement createState
      return new LuffyGear4State();
    }
}

class LuffyGear4State extends State<LuffyGear4> {
  bool isLocalImage = true;

  void _getNetworkImage() {
    setState(() {
      if (isLocalImage) 
        isLocalImage = false;
      else
        isLocalImage = true;
    });
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Luffy Gear 4'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: new Center(
          child: isLocalImage ? new Image(
            image: new AssetImage(
              'assets/luffy_gear_4.png'
            ),
          ) : new Image(
            image: new NetworkImage(
              'https://pre00.deviantart.net/3b2b/th/pre/i/2015/353/3/a/luffy_gear_4_render_by_giorgsavv-d9kmxm1.png'
            ),
          )
        ),
        floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          onPressed: _getNetworkImage,
          child: new Icon(Icons.refresh),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
}