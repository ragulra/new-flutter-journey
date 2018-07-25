import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const URL = 'https://api.opendota.com/api/proPlayers';

void main() {
  _getProPlayers().then((data) {
    runApp(
      MaterialApp(
        title: 'Two Random Pro Player',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomePage(randomPlayers: data),
      )
    );
  });
}

Future<List<dynamic>> _getProPlayers() async{
    var res = await http.get(Uri.encodeFull(URL));

    return json.decode(res.body);
  }


class HomePage extends StatefulWidget {
  final List<dynamic> randomPlayers;

  HomePage({@required this.randomPlayers});

  @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = Random();

  String currentUserName;
  String currentUserTeamName;
  String currentUserAvatar;
  String currentUserAvatarFull;
  String currentLastTimeMatch;

  String otherUserName;
  String otherUserTeamName;
  String otherUserAvatar;
  String otherUserAvatarFull;
  String otherLastTimeMatch;

  void _define() {
    int currentUserIndex = random.nextInt(widget.randomPlayers.length);
    int otherUserIndex = random.nextInt(widget.randomPlayers.length);
    
    currentUserName = widget.randomPlayers[currentUserIndex]['name'] != null ? widget.randomPlayers[currentUserIndex]['name'] : '';
    currentUserTeamName = widget.randomPlayers[currentUserIndex]['team_name'] != null ? widget.randomPlayers[currentUserIndex]['team_name'] : '';
    currentUserAvatar = widget.randomPlayers[currentUserIndex]['avatar'] != null ? widget.randomPlayers[currentUserIndex]['avatar'] : '';
    currentUserAvatarFull = widget.randomPlayers[currentUserIndex]['avatarfull'] != null ? widget.randomPlayers[currentUserIndex]['avatarfull'] : '';
    currentLastTimeMatch = widget.randomPlayers[currentUserIndex]['last_match_time'] != null ? widget.randomPlayers[currentUserIndex]['last_match_time'] : 'Not recorded.';

    otherUserName = widget.randomPlayers[otherUserIndex]['name'] != null ? widget.randomPlayers[otherUserIndex]['name'] : '';
    otherUserTeamName = widget.randomPlayers[otherUserIndex]['team_name'] != null ? widget.randomPlayers[otherUserIndex]['team_name'] : '';
    otherUserAvatar = widget.randomPlayers[otherUserIndex]['avatar'] != null ? widget.randomPlayers[otherUserIndex]['avatar'] : '';
    otherUserAvatarFull = widget.randomPlayers[otherUserIndex]['avatarfull'] != null ? widget.randomPlayers[otherUserIndex]['avatarfull'] : '';
    otherLastTimeMatch = widget.randomPlayers[currentUserIndex]['last_match_time'] != null ? widget.randomPlayers[currentUserIndex]['last_match_time'] : 'Not recorded.';                
  }

  void _switchUser() {
    print('overhere!');
    String backupTeamName;
    String backupAvatar;
    String backupName;
    String backupLastTimeMatch;

    setState(() {
      backupLastTimeMatch = currentLastTimeMatch;
      currentLastTimeMatch = otherLastTimeMatch;
      otherLastTimeMatch = backupLastTimeMatch;

      backupTeamName = currentUserTeamName;
      currentUserTeamName = otherUserTeamName;
      otherUserTeamName = backupTeamName;

      backupAvatar = currentUserAvatarFull;
      currentUserAvatarFull = otherUserAvatarFull;
      otherUserAvatarFull = backupAvatar;

      backupName = currentUserName;
      currentUserName = otherUserName;
      otherUserName = backupName;
    });
  }

  Widget drawerLayout(BuildContext context) {
    
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(currentUserName),
            accountEmail: Text(currentUserTeamName),
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text('Player Details'),
                        ),
                        body: Center(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.network(currentUserAvatarFull),
                                Padding(padding: const EdgeInsets.only(bottom: 10.0)),
                                Text('Name : '+currentUserName),
                                Text('Team Name : '+currentUserTeamName),
                                Text('Last Match Time : '+currentLastTimeMatch)
                              ],
                            ),
                          ),
                        )
                      );
                    }
                  )
                );
              },
              child: currentUserAvatarFull != null ?
                CircleAvatar(backgroundImage: NetworkImage(
                  currentUserAvatarFull)) :
                CircleAvatar(backgroundColor: Color.fromRGBO(
                  random.nextInt(256),
                  random.nextInt(256),
                  random.nextInt(256), 
                  random.nextDouble()),
                  child: Text(currentUserName[0]))
            ),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/juggernaut.jpg'), 
              fit: BoxFit.cover)
            ),
            otherAccountsPictures: <Widget>[
              GestureDetector(
                onTap: () => _switchUser(),
                child: CircleAvatar(
                  child: otherUserAvatarFull != null ?
                    CircleAvatar(backgroundImage: NetworkImage(
                      otherUserAvatarFull)) :
                    CircleAvatar(backgroundColor: Color.fromRGBO(
                      random.nextInt(256),
                      random.nextInt(256),
                      random.nextInt(256), 
                      random.nextDouble()),
                      child: Text(currentUserName[0]))
                    ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                this._define();
              });
            },
            child: ListTile(
              title: Text('Random The Player'),
              trailing: Icon(Icons.person),
            )
          ),
          ListTile(
            title: Text('Settings'),
            trailing: Icon(Icons.settings),
          ),
          ListTile(
            title: Text('Close'),
            trailing: Icon(Icons.close),
          )
        ],
      ),
    );
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      this._define();
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('Random Pro Players'),
          centerTitle: true,
        ),
        drawer: drawerLayout(context),
        body: Center(
          child: Text(
            'SWIPE OR TAP ON MENU',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w300,
              fontFamily: 'Montserrat'
            ),
          ),
        ),
      );
    }
}
