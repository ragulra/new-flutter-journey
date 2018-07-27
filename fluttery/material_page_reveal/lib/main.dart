import 'package:flutter/material.dart';

import 'page.dart';
import 'page_reveal.dart';
import 'page_indicator.dart';

void main() {
  runApp(MaterialApp(
    title: 'Material Page Reveal',
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Page(
            viewModel: pages[0],
            percentVisible: 1.0,
          ),
          PageReveal(
              revealPercent: 1.0,
              child: Page(
                viewModel: pages[1],
                percentVisible: 1.0,
              )),
          PageIndicator(
            viewModel: PagerIndicatorViewModel(
              pages: pages,
              slideDirection: SlideDirection.leftToRight,
              activeIndex: 1,
              slidePercent: 0.0,
            ),
          )
        ],
      ),
    );
  }
}
