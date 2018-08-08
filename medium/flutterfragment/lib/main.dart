import 'package:flutter/material.dart';

import 'package:flutterfragment/air_conditioner_page.dart';
import 'package:flutterfragment/alarm_page.dart';
import 'package:flutterfragment/clock_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Fragment',
    theme: ThemeData.dark(),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  final drawerItems = <DrawerItem>[
    DrawerItem(title: 'Air Conditioner', icon: Icons.ac_unit),
    DrawerItem(title: 'Alarm', icon: Icons.access_alarm),
    DrawerItem(title: 'Clock', icon: Icons.access_time)
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return AirConditionerPage();
        break;
      case 1:
        return AlarmPage();
        break;
      case 2:
        return ClockPage();
        break;

      default:
        Text('Error');
    }
  }

  _onSelectedItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectedItem(i),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: null,
            ),
            Column(
              children: drawerOptions,
            )
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;

  DrawerItem({this.title, this.icon});
}
