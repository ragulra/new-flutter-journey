import 'dart:async';
import 'package:flutter/material.dart';

import 'page.dart';
import 'page_reveal.dart';
import 'page_indicator.dart';
import 'page_dragger.dart';

void main() {
  runApp(MaterialApp(
    title: 'Fortnite Page Reveal',
    home: FortniteHome(),
  ));
}

class FortniteHome extends StatefulWidget {
  @override
  _FortniteHomeState createState() => _FortniteHomeState();
}

class _FortniteHomeState extends State<FortniteHome>
    with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  _FortniteHomeState() {
    slideUpdateStream = StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = AnimatedPageDragger(
                slideDirection: slideDirection,
                transitionGoal: TransitionGoal.open,
                slidePercent: slidePercent,
                slideUpdateStream: slideUpdateStream,
                vsync: this);
          } else {
            animatedPageDragger = AnimatedPageDragger(
                slideDirection: slideDirection,
                transitionGoal: TransitionGoal.closed,
                slidePercent: slideDirection,
                slideUpdateStream: slideUpdateStream,
                vsync: this);

            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger.dispose();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Pages(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          PageReveal(
            revealPercent: slidePercent,
            child: Pages(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          PageIndicator(
            viewModel: PageIndicatorViewModel(
              pages: pages,
              slideDirection: SlideDirection.leftToRight,
              slidePercent: slidePercent,
              activeIndex: activeIndex,
            ),
          ),
          PageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightLeft: activeIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          )
        ],
      ),
    );
  }
}
