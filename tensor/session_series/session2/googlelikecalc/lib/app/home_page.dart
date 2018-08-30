import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String inputString = '';
  double prevValue;
  String value = '';
  String op = 'z';

  bool isNumber(String str) {
    if (str == null) {
      return false;
    }
    return double.parse(str) != null;
  }

  void onPressed(keyValue) {
    print(keyValue);
    switch (keyValue) {
      case 'C':
        op = null;
        prevValue = 0.0;
        value = '';
        setState(() => inputString = '');
        break;
      case '/':
      case 'x':
      case '+':
      case '-':
        op = keyValue;
        value = '';
        prevValue = double.parse(inputString);
        setState(() {
          inputString += keyValue;
        });
        break;
      case '=':
        if (op != null) {
          setState(() {
            switch (op) {
              case 'x':
                inputString =
                    (prevValue * double.parse(value)).toStringAsFixed(0);
                break;
              case '+':
                inputString =
                    (prevValue + double.parse(value)).toStringAsFixed(0);
                break;
              case '-':
                inputString =
                    (prevValue - double.parse(value)).toStringAsFixed(0);
                break;
              case '/':
                inputString =
                    (prevValue / double.parse(value)).toStringAsFixed(2);
                break;
            }
          });
          op = null;
          prevValue = double.parse(inputString);
          value = '';
          break;
        }
        break;
      default:
        if (isNumber(keyValue)) {
          if (op != null) {
            setState(() => inputString += keyValue);
            value = value + keyValue;
          } else {
            setState(() => inputString = '' + keyValue);
            op = 'z';
          }
        } else {
          onPressed(keyValue);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MainState(
      inputValue: inputString,
      prevValue: prevValue,
      value: value,
      op: op,
      onPressed: onPressed,
      child: CalculatorLayout(),
    );
  }
}

class CalcButton extends StatelessWidget {
  final String keyValue;
  final bool smallFont;

  CalcButton({this.keyValue, this.smallFont});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final mainState = MainState.of(context);
    return Expanded(
      child: FlatButton(
        onPressed: () {
          mainState.onPressed(keyValue);
        },
        child: Text(
          keyValue,
          style: TextStyle(
            fontSize: smallFont ? 20.0 : 35.0,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CalculatorLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final mainState = MainState.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top),
          topActionWidget(),
          screenCalc(mainState.inputValue),
          allButtons(),
        ],
      ),
    );
  }

  Widget topActionWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text('DEG'),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget screenCalc(String inputValue) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.only(right: 5.0),
        alignment: Alignment.centerRight,
        child: Text(
          inputValue ?? '0',
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }

  Widget allButtons() {
    return Expanded(
      flex: 3,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.black87,
              child: Column(
                children: <Widget>[
                  makeButtons(rows: '789'),
                  makeButtons(rows: '456'),
                  makeButtons(rows: '123'),
                  makeButtons(rows: '.0='),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black54,
              child: Column(
                children: <Widget>[
                  makeButtons(rows: 'C', smallFont: true),
                  makeButtons(rows: '/', smallFont: true),
                  makeButtons(rows: 'x', smallFont: true),
                  makeButtons(rows: '-', smallFont: true),
                  makeButtons(rows: '+', smallFont: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeButtons({String rows, bool smallFont = false}) {
    List<String> token = rows.split("");
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: token
            .map((e) => CalcButton(
                  keyValue: e,
                  smallFont: smallFont,
                ))
            .toList(),
      ),
    );
  }
}

class MainState extends InheritedWidget {
  final String inputValue;
  final double prevValue;
  final String value;
  final String op;
  final Function onPressed;

  MainState({
    Key key,
    this.inputValue,
    this.prevValue,
    this.value,
    this.op,
    this.onPressed,
    Widget child,
  }) : super(key: key, child: child);

  static MainState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MainState);
  }

  @override
  bool updateShouldNotify(MainState oldWidget) {
    // TODO: implement updateShouldNotify
    return inputValue != oldWidget.inputValue;
  }
}
