import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:fortnitegeek/app/admin_page.dart';
import 'package:fortnitegeek/app/user_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<Null> _loginUser() async {
    var url = 'http://192.168.1.9/fortnitegeek/login_api.php';
    var res = await http.post(url, body: {
        'username': _usernameController.text,
        'password': _passwordController.text
    });

    print(res.body);

    var datauser = json.decode(res.body);

    if (datauser.length == 0) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Text('Username or password wrong!'),
          );
        }
      );
    } else {
      if (datauser[0]['level'] == 'admin') {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => AdminPage(data: datauser[0])
        ), (Route<dynamic> route) => false);
      } else if (datauser[0]['level'] == 'user') {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => UserPage(data: datauser[0])
        ), (Route<dynamic> route) => false);
      }
    }

    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage('assets/fortnitebackground.jpg'),
            color: Colors.black.withOpacity(0.9),
            colorBlendMode: BlendMode.darken,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 80.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              alignment: Alignment.center,
              child: Theme(
                data: ThemeData(
                  primaryColor: Color(0xffc107a2),
                  hintColor: Color(0xfffcf123),
                ),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/logo.png',
                      width: 200.0,
                      height: 200.0,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      controller: _usernameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 35.0),
                    RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      elevation: 0.0,
                      splashColor: Color(0xffc107a2),
                      color: Color(0xfffcf123),
                      icon: Icon(
                        Icons.play_arrow,
                        size: 30.0,
                      ),
                      label: Text(
                        'Login',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      onPressed: () => _loginUser(),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed<List<dynamic>>('/register').then((snapshot) {
                  if (snapshot != null) {
                    setState(() {
                      _usernameController.text = snapshot[0];
                      _passwordController.text = snapshot[1];
                    });
                  }
                });
              },
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 11.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
