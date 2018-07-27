import 'package:flutter/material.dart';

final pages = [
  PageViewModel(
      color: const Color(0xFF678FB4),
      heroAssetPath: 'assets/hotels.png',
      title: 'Hotels',
      body: 'All hotels and hostels are sorted by hospitality rating',
      iconAssetIcon: 'assets/key.png'),
  PageViewModel(
      color: const Color(0xFF65B0B4),
      heroAssetPath: 'assets/banks.png',
      title: 'Banks',
      body: 'We carefully verify all banks before adding them into the app',
      iconAssetIcon: 'assets/wallet.png'),
  PageViewModel(
      color: const Color(0xFF9890BC),
      heroAssetPath: 'assets/stores.png',
      title: 'Stores',
      body: 'All local stores categorized for your convenience',
      iconAssetIcon: 'assets/shopping_cart.png')
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  Page({this.viewModel, this.percentVisible = 1.0});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: double.infinity,
        color: viewModel.color,
        child: Opacity(
          opacity: percentVisible,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform(
                transform: Matrix4.translationValues(
                    0.0, 50.0 * (1.0 - percentVisible), 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Image.asset(
                    viewModel.heroAssetPath,
                    width: 200.0,
                    height: 200.0,
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.translationValues(
                    0.0, 30.0 * (1.0 - percentVisible), 0.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    viewModel.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FlamanteRoma',
                      fontSize: 34.0,
                    ),
                  ),
                ),
              ),
              Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 75.0,
                        right: 8.0,
                        left: 8.0
                      ),
                      child: Text(
                        viewModel.body,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      )))
            ],
          ),
        ));
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetIcon;

  PageViewModel(
      {this.color,
      this.heroAssetPath,
      this.title,
      this.body,
      this.iconAssetIcon});
}
