import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mind_blowing_fact/app/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Null> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    );

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HomePage(user: firebaseUser, googleSignIn: googleSignIn)
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(
              size: 200.0,
            ),
            SizedBox(height: 30.0),
            RaisedButton.icon(
              // color: Theme.of(context).accentColor,
              onPressed: () => _signIn(),
              icon: Icon(Icons.input),
              label: Text(
                'Login With Google',
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w900
                ),
              ),
              elevation: 4.0,
            )
          ],
        ),
      ),
    );
  }
}
