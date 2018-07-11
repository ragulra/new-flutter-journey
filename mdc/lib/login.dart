import 'package:flutter/material.dart';

import 'colors.dart';

class LoginPage extends StatefulWidget {
  @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 80.0),
              Column(
                children: <Widget>[
                  Image.asset('assets/diamond2.png'),
                  const SizedBox(height: 16.0),
                  const Text('SHRINE')
                ],
              ),
              const SizedBox(height: 120.0),
              PrimaryColorOverride(
                color: kShrineBrown900,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username'
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              PrimaryColorOverride(
                color: kShrineBrown900,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password'
                  ),
                  obscureText: true,
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      _usernameController.clear();
                      _passwordController.clear();
                    },
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))
                    ),
                  ),
                  RaisedButton(
                    elevation: 8.0,
                    child: Text('NEXT'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
}

class PrimaryColorOverride extends StatelessWidget {
  final Color color;
  final Widget child;

  const PrimaryColorOverride(
    {Key key,
    this.color,
    this.child}
  ) : super(key: key);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Theme(
        child: child,
        data: Theme.of(context).copyWith(primaryColor: color),
      );
    }
}