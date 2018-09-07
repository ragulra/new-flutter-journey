import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<List<dynamic>> _registerUser() async {
    var url = 'http://192.168.1.9/fortnitegeek/adduser.php';

    var registereddata = await http.post(
      url,
      body: {
        'fullname': _fullnameController.text,
        'username': _usernameController.text,
        'password': _passwordController.text,
        'level': 'user'
      },
    );

    List<dynamic> data = json.decode(registereddata.body);
    return data;
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
            color: Colors.black87,
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
                      controller: _fullnameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Fullname',
                      ),
                    ),
                    SizedBox(height: 20.0),
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
                        'Register',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      onPressed: () => _registerUser().then((data) {
                            Navigator.of(context).pop([
                              data[0]['username'],
                              data[0]['password'],
                            ]);
                          }),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
