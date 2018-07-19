import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Bounce Ball',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
      home: BounceBall(),
    )
  );
}

class BounceBall extends StatefulWidget {
  @override
    _BounceBallState createState() => _BounceBallState();
}

class _BounceBallState extends State<BounceBall> with SingleTickerProviderStateMixin{
  Animation animation;
  AnimationController controller;


  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      controller = AnimationController(
        duration: Duration(milliseconds: 2500),
        vsync: this
      );

      animation = Tween(begin: 0.0, end: 600.0).animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
      controller.forward();
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.green
            ),
            BallBouncing(
              animation: animation,
            )
          ],
        )
      );
    }
}

class BallBouncing extends AnimatedWidget {
  final Animation animation;

  BallBouncing({Key key, this.animation}) : super(key: key, listenable: animation);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Positioned(
        top: animation.value,
        left: (MediaQuery.of(context).size.width - 50) * 0.5,
        child: CircleAvatar(
          radius: animation.value * 0.2,
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            'BUL',
            style: TextStyle(
              fontSize: animation.value * 0.1
            ),
          ),
        ),
      );
    }
}