import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePagePage createState() => _HomePagePage();
}

class _HomePagePage extends State<HomePage> {
  Random rand = Random();
  bool tapcondition;
  int randomcolor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tapcondition = false;
    randomcolor = rand.nextInt(0xffffffff);
  }

  void tapDown(TapDownDetails details) {
    setState(() {
      randomcolor = rand.nextInt(0xffffffff);
    });
  }

  void tapUp(TapUpDetails details) {
    setState(() {
      tapcondition = false;
      print('up');
    });
  }

  void tapCancel() {
    setState(() {
      tapcondition = false;
      print('cancel');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GestureDetector(
        onTapUp: tapUp,
        onTapDown: tapDown,
        onTapCancel: tapCancel,
        onTap: () {
          print('tapped');
        },
        child: Container(
          color: Color(randomcolor),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Text(
              'Tap on me, anywhere!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Color(randomcolor * randomcolor)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
