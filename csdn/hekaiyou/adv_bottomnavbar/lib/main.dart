import 'package:flutter/material.dart';

import 'navigation_icon_view.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Botnavbar',
      home: new BottomNav(),
    )
  );
}

class BottomNav extends StatefulWidget {
  @override
    BottomNavState createState() {
      // TODO: implement createState
      return new BottomNavState();
    }
}

class BottomNavState extends State<BottomNav> with TickerProviderStateMixin{
  int _currentIndex = 2;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];
    for (NavigationIconView view in _navigationViews) {
      transitions.add(view.transition(_type, context));
    }
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      double aValue = aAnimation.value;
      double bValue = bAnimation.value;

      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  void rebuild() {
    setState(() {});
  }

  @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      for (NavigationIconView view in _navigationViews) {
        view.controller.dispose();
      }
    }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _navigationViews = <NavigationIconView>[
        new NavigationIconView(
          icon: new Icon(Icons.ac_unit),
          title: new Text('AC'),
          color: Colors.orangeAccent,
          vsync: this
        ),
        new NavigationIconView(
          icon: new CustomIcon(),
          title: new Text('Custom Icon'),
          color: Colors.blueAccent,
          vsync: this
        ),
        new NavigationIconView(
          icon: new Icon(Icons.memory),
          title: new Text('Memory'),
          color: Colors.redAccent,
          vsync: this
        ),
        new NavigationIconView(
          icon: new Icon(Icons.bug_report),
          title: new Text('Bugs'),
          color: Colors.greenAccent,
          vsync: this
        ),
        new NavigationIconView(
          icon: new Icon(Icons.dashboard),
          title: new Text('Dashboard'),
          color: Colors.purpleAccent,
          vsync: this
        )
      ];

      for (NavigationIconView view in _navigationViews) {
        view.controller.addListener(rebuild);
      }
      _navigationViews[_currentIndex].controller.value = 1.0;
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      final BottomNavigationBar botnavbar = new BottomNavigationBar(
        items: _navigationViews.map((NavigationIconView navigationiconview) {
          return navigationiconview.item;
        }).toList(),
        currentIndex: _currentIndex,
        type: _type,
        onTap: (int index) {
          setState(() {
            _navigationViews[_currentIndex].controller.reverse();
            _currentIndex = index;
            _navigationViews[_currentIndex].controller.forward();
          });
        },
      );

      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Bottom Navigation'),
          actions: <Widget>[
            new PopupMenuButton<BottomNavigationBarType>(
              onSelected: (BottomNavigationBarType value) {
                setState(() {
                  _type = value;            
                });
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<BottomNavigationBarType>>[
                  new PopupMenuItem<BottomNavigationBarType>(
                    value: BottomNavigationBarType.fixed,
                    child: new Text('Fixed'),
                  ),
                  new PopupMenuItem<BottomNavigationBarType>(
                    value: BottomNavigationBarType.shifting,
                    child: new Text('Shifting'),
                  ),
                ];
              },
            )
          ],
        ),
        body: new Center(
          child: _buildTransitionsStack(),
        ),
        bottomNavigationBar: botnavbar,
      );
    }
}

class CustomIcon extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      final IconThemeData iconThemeData = IconTheme.of(context);
      return new Container(
        margin: const EdgeInsets.all(4.0),
        width: iconThemeData.size - 8.0,
        height: iconThemeData.size - 8.0,
        decoration: new BoxDecoration(
          color: iconThemeData.color
        ),
      );
    }
}