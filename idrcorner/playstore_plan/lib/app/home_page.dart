import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:playstore_plan/app/detail_page.dart';
import 'package:playstore_plan/app/add_page.dart';
import 'package:playstore_plan/app/edit_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Playstore Plan'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              this._getData();
              setState(() {});
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('Something wrong occured. Pls try again!'),
              ),
            );
          }

          return snapshot.hasData
              ? ListItem(
                  data: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<List> _getData() async {
    final res = await http.get('http://192.168.1.9/playstore_plan/getdata.php');

    return json.decode(res.body);
  }
}

class ListItem extends StatelessWidget {
  final List data;

  ListItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Random random = Random();
    var color;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, index) {
        color = random.nextInt(0xffffffff);
        return GestureDetector(
          onLongPress: () =>
              showAction(context, data[index], int.parse(data[index]['id'])),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(color),
              child: Text((index + 1).toString()),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            title: Text(data[index]['app_name']),
            subtitle: Text(data[index]['description']),
          ),
        );
      },
    );
  }

  Future deleteData(int index) async {
    var url = 'http://192.168.1.9/playstore_plan/deletedata.php';
    /* only comment */

    http.post(
      url,
      body: {
        'id': index.toString()
      },
    );
  }

  Future showAction(BuildContext context, Map data, int index) async {
    var dialog = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 50.0),
          title: Text(
            'What you gonna do?',
            textAlign: TextAlign.center,
          ),
          titlePadding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          children: <Widget>[
            FlatButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              onPressed: () {
                Navigator.pop(context, ACTION.delete);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              label: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.pop(context, ACTION.edit);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.orange,
              ),
              label: Text(
                'Edit',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.pop(context, ACTION.detail);
              },
              icon: Icon(
                Icons.details,
                color: Colors.green,
              ),
              label: Text(
                'Detail',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );

    switch (dialog) {
      case ACTION.delete:
        deleteData(index);
        break;
      case ACTION.edit:
        print(data);
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => EditPage(data: data, index: index)),
        );
        break;
      case ACTION.detail:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailPage(data: data)),
        );
        break;
    }
  }
}

enum ACTION { delete, edit, detail }
