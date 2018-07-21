import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const API_URL = 'https://api.opendota.com/api/proMatches';

void main() {
  runApp(
    MaterialApp(
      title: 'Pro Match Dota 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent
      ),
      home: Home(),
    )
  );
}

class Home extends StatefulWidget {
  @override
    _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List dataMatch;

  Future<Null> _getMatch() async {
    http.Response response = await http.get(
      Uri.encodeFull(API_URL)
    );

    this.setState(() => dataMatch = json.decode(response.body));
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      this._getMatch();
    }

  Widget _matchItem(int index) {
    var format = DateFormat("d M y");
    String secondEpochTimeStamp = dataMatch[index]['start_time'].toString() + "000";
    int timestamp = int.parse(secondEpochTimeStamp);
    print(timestamp);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text('ID: '+dataMatch[index]['match_id'].toString()),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                color: dataMatch[index]['radiant_win'] ? Colors.green : Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Radiant'),
                        Text(dataMatch[index]['radiant_name'])
                      ],
                    ),
                    Text(dataMatch[index]['radiant_score'].toString())
                  ],
                ),
              ),
              Container(
                color: dataMatch[index]['radiant_win'] ? Colors.red : Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Dire'),
                        Flexible(child: Text(dataMatch[index]['dire_name']))
                      ],
                    ),
                    Text(dataMatch[index]['dire_score'].toString())
                  ],
                )
              )
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(format.format(DateTime.fromMillisecondsSinceEpoch(timestamp))),
              Text(dataMatch[index]['league_name'])
            ],
          )
        ],
      )
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('Pro Match Dota 2'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) => _matchItem(index),
          itemCount: dataMatch == null ? 0 : dataMatch.length,
        ),
      );
    }
}