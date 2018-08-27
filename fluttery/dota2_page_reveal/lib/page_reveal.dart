import 'dart:math';

import 'package:flutter/material.dart';

class PageReveal extends StatelessWidget {
  final double revealPercent;
  final Widget child;

  PageReveal({@required this.revealPercent, @required this.child});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRect(
      clipper: RectangleRevealClipper(revealPercent: revealPercent),
      child: child,
    );
  }
}

class RectangleRevealClipper extends CustomClipper<Rect> {
  final double revealPercent;

  RectangleRevealClipper({@required this.revealPercent});

  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    final epicenter = Offset(size.width / 2, size.height / 2);

    double theta = atan(epicenter.dy / epicenter.dx);
    final distanceToCorner = epicenter.dy / sin(theta);

    final radius = distanceToCorner * revealPercent;
    final diameter = 2 * radius;

    return Rect.fromLTWH(epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
