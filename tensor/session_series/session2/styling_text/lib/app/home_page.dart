import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Random randomThings = Random();

  int next(int min, int max) => min + randomThings.nextInt(max - min);

  List<String> _theFont = [
    'Anton',
    'Inconsolata',
    'Lobster',
    'PlayfairDisplay',
    'Slabo27px',
  ];

  List<FontWeight> _theFontWeight = [
    FontWeight.w100,
    FontWeight.w200,
    FontWeight.w300,
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
    FontWeight.w900,
  ];

  List<FontStyle> _theFontStyle = [
    FontStyle.italic,
    FontStyle.normal,
  ];

  Color randomColor;
  Color randomColorBackground;
  Color randomColorBoxShadow;
  double _theFontSize;
  double _randomValue;
  double _borderRadius;
  int _fontIndex;
  int _fontWeightIndex;
  int _fontStyleIndex;
  String _theText;
  double _x;
  double _y;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomColor = Color(0xff000000);
    randomColorBackground = Color(0xffffffff);
    randomColorBoxShadow = Color(0xff000000);
    _theFontSize = 14.0;
    _randomValue = 0.0;
    _borderRadius = 0.0;
    _fontIndex = 0;
    _fontWeightIndex = 0;
    _fontStyleIndex = 0;
    _theText = 'Something';
    _x = 0.0;
    _y = 0.0;
  }

  void onSubmit(String text) {
    setState(() {
      _theText = text;
    });
    _textController.clear();
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _changeStyle() {
    setState(() {
      randomColor = Color(randomThings.nextInt(0xffffffff));
      randomColorBackground = Color(randomThings.nextInt(0xffffffff));
      randomColorBoxShadow = Color(randomThings.nextInt(0xffffffff));
      _theFontSize = next(14, 50).toDouble();
      _randomValue = randomThings.nextInt(5).toDouble();
      _borderRadius = randomThings.nextInt(1000).toDouble();
      _fontIndex = randomThings.nextInt(_theFont.length);
      _fontWeightIndex = randomThings.nextInt(_theFontWeight.length);
      _fontStyleIndex = randomThings.nextInt(_theFontStyle.length);
    });
  }

  void analog(IconData icon) {
    if (_y < -100.0 || _y > 100.0 || _x < -100.0 || _x > 100.0) {
      setState(() {
        if (icon == Icons.arrow_drop_up) {
          _y = -99.0;
        } else if (icon == Icons.arrow_drop_down) {
          _y = 99.0;
        } else if (icon == Icons.arrow_left) {
          _x = -99.0;
        } else if (icon == Icons.arrow_right) {
          _x = 99.0;
        }
      });

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('maximum value reached!'),
      ));
    } else {
      setState(() {
        if (icon == Icons.arrow_drop_up) {
          _y -= 3.0;
        } else if (icon == Icons.arrow_drop_down) {
          _y += 3.0;
        } else if (icon == Icons.arrow_left) {
          _x -= 3.0;
        } else if (icon == Icons.arrow_right) {
          _x += 3.0;
        }
      });
    }
    print('$_x, $_y');
  }

  Widget makeButtons(List<IconData> icons) {
    return Row(
        mainAxisAlignment: icons.length == 1
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: icons.map(
          (icon) {
            return Expanded(
              child: IconButton(
                onPressed: () => analog(icon),
                icon: Icon(icon),
                color: Theme.of(context).primaryColor,
                splashColor: Theme.of(context).accentColor,
              ),
            );
          },
        ).toList());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                labelText: 'Text to change',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 15.0),
                          IconButton(
                            splashColor: Theme.of(context).accentColor,
                            onPressed: () => onSubmit(_textController.text),
                            icon: Icon(Icons.send),
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      )),
                  SizedBox(height: 20.0),
                  makeButtons([Icons.arrow_drop_up]),
                  makeButtons([Icons.arrow_left, Icons.arrow_right]),
                  makeButtons([Icons.arrow_drop_down]),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: randomColorBackground,
                borderRadius: BorderRadius.circular(_borderRadius),
                boxShadow: [
                  BoxShadow(
                      color: randomColorBoxShadow,
                      blurRadius: _randomValue,
                      spreadRadius: _randomValue,
                      offset: Offset(_randomValue, _randomValue))
                ],
              ),
              child: Center(
                  child: Transform(
                transform: Matrix4.translationValues(_x, _y, 0.0),
                child: Text(
                  _theText,
                  style: TextStyle(
                    color: randomColor,
                    fontSize: _theFontSize,
                    fontFamily: _theFont[_fontIndex],
                    fontStyle: _theFontStyle[_fontStyleIndex],
                    fontWeight: _theFontWeight[_fontWeightIndex],
                    wordSpacing: _randomValue,
                  ),
                ),
              )),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _changeStyle(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
