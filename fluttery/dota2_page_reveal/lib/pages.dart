import 'package:flutter/material.dart';

final pages = [
  PageViewModel(
      coverImagePath: 'assets/cover1.jpg',
      title: 'Free to Play',
      subtitle: 'Once you downloaded the game, you can start playing the game'),
  PageViewModel(
      coverImagePath: 'assets/cover2.jpg',
      title: 'Play with Unique Player',
      subtitle: 'There is a lot of Player Dota and They are very funny'),
  PageViewModel(
      coverImagePath: 'assets/cover3.jpg',
      title: 'Any Heroes',
      subtitle: 'You can play with any heroes you wanted without \'Paying\''),
  PageViewModel(
      coverImagePath: 'assets/cover4.jpg',
      title: 'Say anything you want',
      subtitle: 'LAKAD MATATAAG... NORMALIN... NORMALIN... TANGINA MO... GAGO'),
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;

  Page({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset(
              viewModel.coverImagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                viewModel.title,
                style: TextStyle(
                    color: Colors.white, fontSize: 34.0, fontFamily: 'Oswald'),
              ),
              SizedBox(height: 10.0),
              Text(
                viewModel.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 18.0, fontFamily: 'Raleway'),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class PageViewModel {
  final String coverImagePath;
  final String title;
  final String subtitle;

  PageViewModel({
    @required this.coverImagePath,
    @required this.title,
    @required this.subtitle,
  });
}
