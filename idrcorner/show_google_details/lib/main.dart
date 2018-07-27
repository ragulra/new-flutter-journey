import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _loginGoogle = GoogleSignIn();
final _auth = FirebaseAuth.instance;

void main() {
  runApp(MaterialApp(
    title: 'Show Google Details',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Color(0xFF2a0e91), accentColor: Color(0xFF9a0eaa)),
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatelessWidget {
  Future<dynamic> _loginWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _loginGoogle.signIn();
    GoogleSignInAuthentication authentication = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
      idToken: authentication.idToken, accessToken: authentication.accessToken
    );

    return user;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft,
                colors: [Colors.green, Colors.blue])),
        child: Center(
          child: RaisedButton(
            onPressed: () {
              _loginWithGoogle().then((user) {
                print(user);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(
                        email: user.email,
                        username: user.displayName,
                        photoUrl: user.photoUrl)));
              });
            },
            child: Text(
              'Login With Google',
              style: TextStyle(
                color: Theme.of(context).accentColor
              ),
            ),
            color: Theme.of(context).primaryColor,
            highlightColor: Theme.of(context).primaryColor.withOpacity(0.7),
            highlightElevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(
                color: Theme.of(context).accentColor,
                width: 2.0
              )
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 20.0
            ),
          ),
        ),
      ),
    );
  }
}

final _homeScreenDetailStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w100,
    wordSpacing: 3.0,
    letterSpacing: 2.0);

class HomeScreen extends StatelessWidget {
  final String email;
  final String username;
  final String photoUrl;

  HomeScreen(
      {@required this.email, @required this.username, @required this.photoUrl})
      : assert(email != null),
        assert(username != null),
        assert(photoUrl != null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('User Google Detail'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(photoUrl),
              Padding(padding: const EdgeInsets.only(bottom: 10.0)),
              Text('Email: ' + email, style: _homeScreenDetailStyle),
              Padding(padding: const EdgeInsets.only(bottom: 10.0)),
              Text('Username: ' + username, style: _homeScreenDetailStyle),
            ],
          ),
        ),
      ),
    );
  }
}
