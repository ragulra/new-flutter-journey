import 'package:flutter/material.dart';

class NavigationIconView {
  final Widget _icon;
  final Color _color;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  NavigationIconView({
    Widget icon,
    Widget title,
    Color color,
    TickerProvider vsync
  }) :
    _icon = icon,
    _color = color,
    item = new BottomNavigationBarItem(
      icon: icon,
      title: title
    ),
    controller = new AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync
    ) {
      _animation = new CurvedAnimation(
        parent: controller,
        curve: new Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)
      );
    }

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light ?
        themeData.primaryColor : themeData.accentColor;
    }

    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.2),
          end: const Offset(2.0, 0.0)
        ).animate(_animation),
        child: new IconTheme(
          data: new IconThemeData(
            color: iconColor,
            size: 120.0
          ),
          child: _icon,
        ),
      ),
    );
  }
}