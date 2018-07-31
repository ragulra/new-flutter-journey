import 'package:flutter/material.dart';

final pages = [
  PagesViewModel(
    backgroundImagePath: 'assets/fortnite1.png',
    title: 'Looting',
    subtitle: 'Find the best place to get your best loot.',
    icon: Icons.build
  ),
  PagesViewModel(
    backgroundImagePath: 'assets/fortnite2.jpg',
    title: 'Dancing',
    subtitle: 'Every dance means a lot.',
    icon: Icons.people
  ),
  PagesViewModel(
    backgroundImagePath: 'assets/fortnite1.png',
    title: 'Survive',
    subtitle: 'Become the number one is the best thing.',
    icon: Icons.pan_tool
  ),
];

class Pages extends StatelessWidget {
  final PagesViewModel viewModel;
  final double percentVisible;

  Pages({@required this.viewModel, this.percentVisible = 1.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: percentVisible,
          child: Transform(
            transform: Matrix4.translationValues(
              50.0 * (1.0 - percentVisible),
              0.0,
              0.0,
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    viewModel.backgroundImagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Opacity(
            opacity: percentVisible,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Transform(
                  transform: Matrix4.translationValues(
                      50.0 * (1.0 - percentVisible), 0.0, 0.0),
                  child: Stack(
                    children: <Widget>[
                      Text(
                        viewModel.title,
                        style: TextStyle(
                          fontSize: 34.5,
                          color: Colors.purple,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3.0,
                        ),
                      ),
                      Text(
                        viewModel.title,
                        style: TextStyle(
                          fontSize: 34.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 3.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Transform(
                  transform: Matrix4.translationValues(
                      50.0 * (1.0 - percentVisible), 0.0, 0.0),
                  child: Stack(
                    children: <Widget>[
                      Text(
                        viewModel.subtitle,
                        style: TextStyle(
                            fontSize: 17.5,
                            color: Colors.purple,
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        viewModel.subtitle,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PagesViewModel {
  final String backgroundImagePath;
  final String title;
  final String subtitle;
  final IconData icon;

  PagesViewModel({this.backgroundImagePath, this.title, this.subtitle, this.icon});
}
