import 'dart:ui' as ui;
import 'dart:async';

import 'package:flutter/material.dart';
import 'page_indicator.dart';

class PageDragger extends StatefulWidget {
  final bool canDragLeftToRight;
  final bool canDragRightToLeft;
  final StreamController<SlideUpdate> slideUpdateStream;

  PageDragger({
    this.canDragLeftToRight,
    this.canDragRightToLeft,
    this.slideUpdateStream,
  });

  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  static const FULL_TRANSITION_PX = 300.0;

  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;

  void _onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart.dx - newPosition.dx;
      if (dx > 0.0 && widget.canDragRightToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0 && widget.canDragLeftToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      if (slideDirection != SlideDirection.none) {
        slidePercent = (dx / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }

      widget.slideUpdateStream.add(SlideUpdate(
          updateType: UpdateType.dragging,
          direction: slideDirection,
          slidePercent: slidePercent));

      print('Dragging $slideDirection at $slidePercent%');
    }
  }

  void _onDragEnd(DragEndDetails details) {
    widget.slideUpdateStream.add(SlideUpdate(
        updateType: UpdateType.doneDragging,
        slidePercent: 0.0,
        direction: SlideDirection.none));

    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
    );
  }
}

class AnimatedPageDragger {
  static const PERCENT_PER_MILLISECOND = 0.005;
  final slideDirection;
  final transitionGoal;

  AnimationController completionAnimationController;

  AnimatedPageDragger({
    this.slideDirection,
    this.transitionGoal,
    slidePercent,
    StreamController<SlideUpdate> slideUpdateStream,
    TickerProvider vsync,
  }) {
    final startSlidePercent = slidePercent;
    var endSlidePercent;
    var duration;

    if (transitionGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;
      final slideRemaining = 1.0 - slidePercent;
      duration = Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
    } else {
      endSlidePercent = 0.0;
      duration = Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }

    completionAnimationController =
        AnimationController(duration: duration, vsync: vsync)
          ..addListener(() {
            slidePercent = ui.lerpDouble(
              startSlidePercent,
              endSlidePercent,
              completionAnimationController.value,
            );
            SlideUpdate(
              updateType: UpdateType.dragging,
              direction: slideDirection,
              slidePercent: slidePercent,
            );
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              slideUpdateStream.add(
                SlideUpdate(
                  updateType: UpdateType.doneAnimating,
                  direction: slideDirection,
                  slidePercent: endSlidePercent,
                ),
              );
            }
          });
  }

  void run() {
    print('it\'s running boi.');
    completionAnimationController.forward(from: 0.0);
  }

  void dispose() {
    completionAnimationController.dispose();
  }
}

enum TransitionGoal {
  open,
  close,
}
enum UpdateType {
  dragging,
  doneDragging,
  animating,
  doneAnimating,
}

class SlideUpdate {
  final direction;
  final slidePercent;
  final updateType;

  SlideUpdate({
    this.updateType,
    this.direction,
    this.slidePercent,
  });
}
