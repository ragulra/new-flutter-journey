import 'package:flutter/material.dart';

import 'page_comp.dart' as computer;
import 'page_headset.dart' as headset;
import 'page_radio.dart' as radio;
import 'page_smartphone.dart' as smartphone;

void main(){
  runApp(
    new MaterialApp(
      title: 'Tab Bar',
      home: new Home(),
    )
  );
}

class Home extends StatefulWidget {
  @override
    HomeState createState() {
      // TODO: implement createState
      return new HomeState();
    }
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController controller;

  @override
    void dispose() {
      // TODO: implement dispose
      controller.dispose();
      super.dispose();
    }

  @override
    void initState() {
      // TODO: implement initState
      controller = new TabController(vsync: this, length: 4);
      super.initState();
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.tealAccent,
          title: new Text('Daftar Elektronik'),
          bottom: new TabBar(
            controller: controller,
            tabs: <Widget>[
              new Tab(
                icon: new Icon(Icons.computer),
                text: 'Computer',
              ),
              new Tab(
                icon: new Icon(Icons.headset),
                text: 'Headset',
              ),
              new Tab(
                icon: new Icon(Icons.radio),
                text: 'Radio',
              ),
              new Tab(
                icon: new Icon(Icons.phone),
                text: 'Phone',
              )
            ],
          ),
        ),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new computer.Computer(),
            new headset.Headset(),
            new radio.Radio(),
            new smartphone.SmartPhone()
          ],
        ),
        bottomNavigationBar: new Material(
          color: Colors.tealAccent,
          child: new TabBar(
            controller: controller,
            tabs: <Widget>[
              new Tab(
                icon: new Icon(Icons.computer),
              ),
              new Tab(
                icon: new Icon(Icons.headset),
              ),
              new Tab(
                icon: new Icon(Icons.radio),
              ),
              new Tab(
                icon: new Icon(Icons.phone),
              )
            ],
          ),
        ),
      );
    }
}
