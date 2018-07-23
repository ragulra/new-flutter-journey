import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'R Company Sign Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
        textSelectionColor: Colors.red,
        textSelectionHandleColor: Colors.red,
        hintColor: Colors.white.withOpacity(0.3),
        textTheme: TextTheme(
          subhead: TextStyle(color: Colors.white),
        )
      ),
      home: SignUp()
    )
  );
}

class SignUp extends StatefulWidget {
  @override
    _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String text = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        key: _globalKey,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/bestcity.jpg',
                  ),
                  fit: BoxFit.cover,
                )
              ),
            ),
            BackdropFilter(
              filter:  ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(color: Colors.white.withOpacity(0.0)),
            ),
            ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Stack(
                          children: <Widget>[
                            Text('R', style: TextStyle(
                              color: Colors.black,
                              fontSize: 79.0
                              ),
                            ),
                            Text('R', style: TextStyle(
                              color: Colors.white,
                              fontSize: 75.0
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'email',
                              hintStyle: TextStyle(
                                color: Theme.of(context).hintColor
                              ),
                            ),
                            onSubmitted: (String str) {
                              setState(() {
                                text = 'Your email is '+str + '\n';
                                _emailController.clear();
                              });
                            },
                          ),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: 'username',
                              hintStyle: TextStyle(
                                color: Theme.of(context).hintColor
                              )
                            ),
                            onSubmitted: (String str) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Text(
                                        'Your username is '+str,
                                        style: TextStyle(fontSize: 20.0, color: Theme.of(context).textTheme.body1.color),
                                      ),
                                      actions: <Widget>[
                                        RaisedButton(
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('OK', style: TextStyle(color: Colors.white)),
                                        )
                                      ],
                                    );
                                }
                              );
                              _usernameController.clear();
                            },
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'password',
                              hintStyle: TextStyle(
                                color: Theme.of(context).hintColor
                              )
                            ),
                            obscureText: true,
                            onSubmitted: (String str) {
                              _globalKey.currentState.showSnackBar(SnackBar(content: Text('Your password is : '+str)));
                              _passwordController.clear();
                            },
                          )
                        ],
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 18.0
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Text(
                                'TERM',
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 18.0
                                ),
                              )
                            )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: MediaQuery.of(context).padding.top - 10,
              child: Text(text, style: TextStyle(color: Colors.white)),
            )
          ],
        )
      );
    }
}