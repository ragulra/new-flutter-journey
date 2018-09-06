import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _controller;

  List<IconData> icons = [
    Icons.launch,
    Icons.stop,
    Icons.pause,
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: AnimatedBox(
                  controller: _controller,
                ),
              ),
            ),
          ),
          Divider(),
          Container(
            child: Row(
                children: icons.map((icon) {
              return Expanded(
                child: IconButton(
                  icon: Icon(icon),
                  iconSize: 20.0,
                  onPressed: () => onPressed(icon),
                ),
              );
            }).toList()),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      print('Animation Canceled!');
    }
  }

  Future _stopAnimation() async {
    _controller.stop();
  }

  Future _pauseAnimation() async {
    
  }

  void onPressed(IconData icon) {
    if (icon == Icons.launch) {
      _startAnimation();
    } else if (icon == Icons.stop) {
      _stopAnimation();
    } else if (icon == Icons.pause) {
      _pauseAnimation();
    }
  }
}

class AnimatedBox extends StatelessWidget {
  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> movement;
  final Animation<BorderRadius> radius;
  final Animation<Color> color;
  final Animation<double> rotate;

  AnimatedBox({Key key, this.controller})
      : opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.1,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        rotate = Tween<double>(begin: 0.0, end: 3.141 * 4).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.3,
              curve: Curves.ease,
            ),
          ),
        ),
        movement = EdgeInsetsTween(
                begin: EdgeInsets.only(bottom: 10.0, left: 0.0),
                end: EdgeInsets.only(bottom: 100.0, left: 75.0))
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.4,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        width = Tween<double>(begin: 50.0, end: 200.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.4,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        height = Tween<double>(begin: 50.0, end: 200.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.4,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        radius = BorderRadiusTween(
                begin: BorderRadius.circular(0.0),
                end: BorderRadius.circular(100.0))
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              0.75,
              curve: Curves.ease,
            ),
          ),
        ),
        color = ColorTween(begin: Colors.red[200], end: Colors.deepOrange[900])
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.75,
              curve: Curves.linear,
            ),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          padding: movement.value,
          transform: Matrix4.identity()..rotateZ(rotate.value),
          alignment: Alignment.center,
          child: Opacity(
            opacity: opacity.value,
            child: Container(
              width: width.value,
              height: height.value,
              decoration: BoxDecoration(
                  color: color.value,
                  border: Border.all(
                    color: Colors.cyan,
                    width: 2.0,
                  ),
                  borderRadius: radius.value),
            ),
          ),
        );
      },
    );
  }
}
