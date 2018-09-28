import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mind_blowing_fact/app/post_dialog.dart';
import 'package:mind_blowing_fact/app/post_item.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  HomePage({@required this.user, @required this.googleSignIn});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))),
              width: double.infinity,
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(widget.googleSignIn.currentUser.photoUrl),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        widget.googleSignIn.currentUser.displayName,
                        style: TextStyle(
                            fontFamily: 'JosefinSans', color: Colors.white),
                      ),
                      Text(
                        widget.googleSignIn.currentUser.email,
                        style: TextStyle(
                          fontFamily: 'JosefinSans',
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Column(
                children: <Widget>[
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                  PostedItem(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 8.0,
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return PostDialog(
                  onFactPosted: () {

                  },
                  controller: postController,
                );
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
