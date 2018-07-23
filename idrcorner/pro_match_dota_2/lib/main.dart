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
      theme: ThemeData.dark(),
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

    var format = DateFormat("d/M/y h:m:s");
    String secondEpochTimeStamp = dataMatch[index]['start_time'].toString() + "000";
    int timestamp = int.parse(secondEpochTimeStamp);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: dataMatch[index]['radiant_win'] ? 
              Colors.green.withOpacity(0.3) : 
              Colors.red.withOpacity(0.3),
            offset: Offset(1.0, 1.0),
            blurRadius: 1.0
          )
        ]
      ),
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            dataMatch[index]['league_name'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'ID: '+dataMatch[index]['match_id'].toString(),
                style: TextStyle(
                  fontSize: 9.0
                ),
              ),
              Text(
                format.format(DateTime.fromMillisecondsSinceEpoch(timestamp)),
                style: TextStyle(
                  fontSize: 9.0
                ),
              )
            ],
          ),
          Container(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Team Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Container(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Radiant',
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Dire',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Container(width: 20.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(dataMatch[index]['radiant_name'] == null ? 'Unknown Team Name' : dataMatch[index]['radiant_name']),
                          Text(dataMatch[index]['dire_name'] == null ? 'Unknown Team Name' : dataMatch[index]['dire_name']),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Score',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Container(height: 6.0),
                  Text(
                    dataMatch[index]['radiant_score'].toString(),
                    style: TextStyle(
                      color: dataMatch[index]['radiant_score'] > dataMatch[index]['dire_score'] ?
                        Colors.green : Colors.red,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                  Text(
                    dataMatch[index]['dire_score'].toString(),
                    style: TextStyle(
                      color: dataMatch[index]['radiant_score'] > dataMatch[index]['dire_score'] ?
                        Colors.red : Colors.green,
                      fontWeight: FontWeight.w900
                    ),
                  )
                ],
              ),
            ],
          ),
          Divider(),
          Text(
            dataMatch[index]['radiant_win'] ? 'RADIANT WIN' : 'DIRE WIN',
            style: TextStyle(
              color: dataMatch[index]['radiant_win'] ? Colors.green : Colors.red
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('Pro Match Dota 2'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) => _matchItem(index),
          itemCount: dataMatch == null ? 0 : dataMatch.length,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        ),
      );
    }
}