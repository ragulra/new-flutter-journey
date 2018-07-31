import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'page.dart';

class PageIndicator extends StatelessWidget {
  final PageIndicatorViewModel viewModel;

  PageIndicator({
    @required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; i++) {
      final page = viewModel.pages[i];

      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isCircle = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.slideDirection == SlideDirection.leftToRight);

      bubbles.add(
        PageBubble(
          viewModel: PageBubbleViewModel(
            icon: page.icon,
            isCircle: isCircle,
            activePercent: percentActive,
          ),
        )
      );
    }

    final BUBLEWIDTH = 55.0;
    final baseTranslation =
        ((viewModel.pages.length * BUBLEWIDTH) / 2) - (BUBLEWIDTH / 2);
    var translation = baseTranslation - (viewModel.activeIndex * BUBLEWIDTH);
    if (viewModel.slideDirection == SlideDirection.leftToRight) {
      translation += BUBLEWIDTH * viewModel.slidePercent;
    } else if (viewModel.slideDirection == SlideDirection.rightToLeft) {
      translation -= BUBLEWIDTH * viewModel.slidePercent;
    }

    return Column(
      children: <Widget>[
        Expanded(child: SizedBox()),
        Transform(
          transform: Matrix4.translationValues(
            translation,
            0.0,
            0.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ),
        )
      ],
    );
  }
}

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

class PageIndicatorViewModel {
  final List<PagesViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PageIndicatorViewModel({
    @required this.pages,
    @required this.activeIndex,
    @required this.slideDirection,
    @required this.slidePercent,
  });
}

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;

  PageBubble({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 55.0,
      height: 65.0,
      child: Center(
        child: Container(
          width: ui.lerpDouble(
            20.0,
            45.0,
            viewModel.activePercent,
          ),
          height: ui.lerpDouble(
            20.0,
            45.0,
            viewModel.activePercent,
          ),
          decoration: BoxDecoration(
              shape: viewModel.isCircle ? BoxShape.circle : BoxShape.rectangle,
              color: Colors.white),
          child: Opacity(
            opacity: viewModel.activePercent,
            child: Icon(
              viewModel.icon,
            ),
          ),
        ),
      ),
    );
  }
}

class PageBubbleViewModel {
  final IconData icon;
  final bool isCircle;
  final double activePercent;

  PageBubbleViewModel({
    this.icon,
    this.isCircle,
    this.activePercent,
  });
}
