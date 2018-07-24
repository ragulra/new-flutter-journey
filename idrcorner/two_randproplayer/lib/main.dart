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

  void _switchUser(
    {String currentUser, 
      String otherUser, 
      String currentAvatar, 
      String otherAvatar,
      String currentUserTeam,
     String otherUserTeam}) 
    {

    String backupTeamName;
    String backupAvatar;
    String backupName;

    setState(() {
      backupTeamName = currentUserTeam;
      currentUserTeam = otherUserTeam;
      otherUserTeam = backupTeamName;

      backupAvatar = currentAvatar;
      currentAvatar = otherAvatar;
      otherAvatar = backupAvatar;

      backupName = currentUser;
      currentUser = otherUser;
      otherUser = backupName;
    });
  }

  Widget drawerLayout(BuildContext context) {
    Random random = Random();
    int currentUserIndex = random.nextInt(widget.randomPlayers.length);
    int otherUserIndex = random.nextInt(widget.randomPlayers.length);
    
    String randomName = widget.randomPlayers[currentUserIndex]['name'];
    String randomTeamName = widget.randomPlayers[currentUserIndex]['team_name'];
    String randomAvatar = widget.randomPlayers[currentUserIndex]['avatar'];
    String randomAvatarFull = widget.randomPlayers[currentUserIndex]['avatarfull'];

    String currentUserName = randomName;
    String currentUserTeamName = randomTeamName;
    String currentUserAvatar = randomAvatar;
    String currentUserAvatarFull = randomAvatarFull;

    String otherUserName = randomName;
    String otherUserTeamName = randomTeamName;
    String otherUserAvatar = randomAvatar;

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
                        body: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(currentUserAvatarFull),
                              Padding(padding: const EdgeInsets.only(bottom: 10.0)),
                              Text('Name : '+currentUserName),
                              Text('Team Name : '+currentUserTeamName),
                              Text('Last Match Time : '+widget.randomPlayers[currentUserIndex]['last_match_time'] != null ?
                                  widget.randomPlayers[currentUserIndex]['last_match_time'] :
                                  'Not recorded.')
                            ],
                          ),
                        ),
                      );
                    }
                  )
                );
              },
              child: widget.randomPlayers[currentUserIndex]['avatar'] != null ?
                CircleAvatar(backgroundImage: NetworkImage(
                  currentUserAvatar)) :
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
                onTap: () => _switchUser(
                  currentUser: currentUserName,
                  currentAvatar: currentUserAvatar,
                  currentUserTeam: currentUserTeamName,
                  otherUser: otherUserName,
                  otherAvatar: otherUserAvatar,
                  otherUserTeam: otherUserTeamName
                ),
                child: CircleAvatar(
                  child: widget.randomPlayers[otherUserIndex]['avatar'] != null ?
                    CircleAvatar(backgroundImage: NetworkImage(
                      otherUserAvatar)) :
                    CircleAvatar(backgroundColor: Color.fromRGBO(
                      random.nextInt(256),
                      random.nextInt(256),
                      random.nextInt(256), 
                      random.nextDouble()),
                      child: Text(currentUserName[0]))
                    ),
              )
            ],
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
