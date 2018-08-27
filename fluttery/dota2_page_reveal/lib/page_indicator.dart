import 'package:flutter/material.dart';

import 'package:dota2_page_reveal/pages.dart';

class PageIndicator extends StatelessWidget {
  final PageIndicatorViewModel viewModel;

  PageIndicator({@required this.viewModel});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Indicator> indicators = [];
    for (var i = 0; i < viewModel.pages.length; i++) {

      indicators.add(
        Indicator(
          viewModel: IndicatorViewModel(
            isActive: i == viewModel.activeIndex,
            activePercent: 0.0,
          ),
        ),
      );
    }
    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: indicators),
        SizedBox(height: 10.0)
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
  final List<PageViewModel> pages;
  final int activeIndex;
  final double slidePercent;
  final SlideDirection slideDirection;

  PageIndicatorViewModel({
    @required this.pages,
    @required this.activeIndex,
    this.slidePercent,
    this.slideDirection,
  });
}

class Indicator extends StatelessWidget {
  final IndicatorViewModel viewModel;

  Indicator({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: viewModel.isActive
          ? Transform(
              transform: Matrix4.translationValues(
                25 * viewModel.activePercent,
                0.0,
                0.0,
              ),
              child: Image.asset(
                'assets/dota.ico',
                height: 20.0,
                width: 20.0,
              ),
            )
          : Transform(
              transform: Matrix4.translationValues(
                20 * viewModel.activePercent,
                0.0,
                0.0,
              ),
              child: Container(
                height: 10.0,
                width: 10.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}

class IndicatorViewModel {
  final bool isActive;
  final double activePercent;

  IndicatorViewModel({
    @required this.isActive,
    @required this.activePercent,
  });
}
