import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Drag n Drop Balls',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
      home: HomeBall(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class HomeBall extends StatefulWidget {
  @override
    _HomeBallState createState() => _HomeBallState();
}

class _HomeBallState extends State<HomeBall> {
  Color coughColor = Colors.grey;
  
  Widget targetBall() {
    return Positioned(
      left: (MediaQuery.of(context).size.width / 2) - 100,
      bottom: 0.0,
      child: DragTarget(
        onAccept: (Color color) {
          coughColor = color;
        },
        builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
          return CircleAvatar(
            radius: 100.0,
            backgroundColor: accepted.isEmpty ? coughColor : Colors.grey.shade200,
            child: Center(
              child: Text('Over here!'),
            ),
          );
        },
      ),
    );
  }
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: <Widget>[
            DragBall(
              initPos: Offset(0.0, 0.0),
              label: 'Bul 1',
              itemColor: Colors.yellow,
              radius: 50.0,
            ),
            DragBall(
              initPos: Offset(MediaQuery.of(context).size.width - 150 , 0.0),
              label: 'Bul 2',
              itemColor: Colors.red,
              radius: 75.0,
            ),
            DragBall(
              initPos: Offset(MediaQuery.of(context).size.width - 200 , 0.0),
              label: 'Bul 3',
              itemColor: Colors.teal,
              radius: 25.0,
              fontSize: 12.0,
            ),
            targetBall()
          ],
        ),
      );
    }
}

class DragBall extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;
  final double radius;
  final double fontSize;

  DragBall({
    this.initPos,
    this.label,
    this.itemColor,
    this.radius,
    this.fontSize = 20.0
  });

  @override
    _DragBallState createState() => _DragBallState();
}

class _DragBallState extends State<DragBall> {
  Offset position = Offset(0.0, 0.0);

  Widget theBall({double opt = 1.0, double radWhenDragging = 0.0}) {
      return CircleAvatar(
        backgroundColor: widget.itemColor.withOpacity(opt),
        radius: widget.radius + radWhenDragging,
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: widget.fontSize
            ),
          ),
        ),
      );
    }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      position = widget.initPos;
    }

  
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          onDraggableCanceled: (velocity, offset) {
              setState(() {
                position = offset;
              });
          },
          // onDragStarted: ,
          // onDragCompleted: ,
          feedback: theBall(opt: 0.5, radWhenDragging: 15.0),
          data: widget.itemColor,
          child: theBall()
        )
      );
    }
}