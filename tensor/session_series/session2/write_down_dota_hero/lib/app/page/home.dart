import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:write_down_dota_hero/app/data/heroes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<SharedPreferences> _sPrefs = SharedPreferences.getInstance();
  final TextEditingController controller = TextEditingController();
  ScrollController listViewController;
  List<String> dataKeeper;
  List<dynamic> inputData;
  Map savedData;
  String dataToSave;
  bool wantSave;
  int i = 0;

  Future<bool> _checkDecision(String heroname) async {
    bool decision = false;
    // Heroes.data.forEach(
    //   (hero) {
    //     if (heroname.toLowerCase() ==
    //             hero['hero_name'].toString().toLowerCase() ||
    //         heroname.toLowerCase() == hero['aka'].toString().toLowerCase()) {
    //       savedData = hero;
    //       wantSave = true;

    //       decision = wantSave;
    //     } else {
    //       savedData = {};
    //       wantSave = false;

    //       decision = wantSave;
    //     }
    //   },
    // );
    for (var i = 0; i < Heroes.data.length; i++) {
      if (heroname.toLowerCase() ==
              Heroes.data[i]['hero_name'].toString().toLowerCase() ||
          heroname.toLowerCase() ==
              Heroes.data[i]['aka'].toString().toLowerCase()) {
        savedData = Heroes.data[i];
        wantSave = true;

        decision = wantSave;
        break;
      }
    }
    return decision;
  }

  Future<Null> addList(String heroname) async {
    if (heroname.isEmpty) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                'Cannot be empty!',
                textAlign: TextAlign.center,
              ),
            );
          });
    } else {
      _checkDecision(heroname).then((decision) async {
        if (decision) {
          final SharedPreferences prefs = await _sPrefs;
          dataToSave = json.encode(savedData);
          print(dataToSave);
          dataKeeper.add(dataToSave);
          prefs.setStringList('data', dataKeeper);
          setState(() {
            controller.clear();
          });
        } else {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('There is no hero named ' + heroname),
              );
            },
          );
        }
      });
    }
    final SharedPreferences prefs = await _sPrefs;
    var length = prefs.getStringList('data').length;
    listViewController.animateTo(50.0 * length,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  Future<Null> getList() async {
    final SharedPreferences prefs = await _sPrefs;
    print(prefs.getStringList('data'));
    if (prefs.getStringList('data') != null) {
      inputData = json.decode(prefs.getStringList('data').toString());
      setState(() {});
    }
  }

  Future<Null> clearList() async {
    final SharedPreferences prefs = await _sPrefs;
    prefs.clear();
    setState(() {
      inputData = [];
      dataKeeper = [];
    });
  }

  Future<Null> updateList(String aka) async {
    final SharedPreferences prefs = await _sPrefs;
    int i = 0;
    int indexToDelete;
    Map hero;
    setState(() {
      prefs.getStringList('data').forEach((data) {
        hero = json.decode(data);
        if (hero['aka'] == aka) {
          indexToDelete = i;
        }
        i++;
      });
      inputData.removeAt(indexToDelete);
      dataKeeper.removeAt(indexToDelete);
    });
    prefs.setStringList('data', dataKeeper);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listViewController = ScrollController(initialScrollOffset: 0.0);
    inputData = [];
    wantSave = false;
    dataToSave = '';
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      if (prefs.getStringList('data') != null) {
        print('ada');
        dataKeeper = [];
        prefs.getStringList('data').forEach((data) {
          dataKeeper.add(data);
        });
        print(dataKeeper);
      } else {
        print('gak ada');
        dataKeeper = [];
      }
    });
  }

  Widget controlPanel() {
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Hero Name',
                hintText: 'Write here...',
                contentPadding: const EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton.icon(
                  color: Colors.green.shade700,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  icon: Icon(Icons.send),
                  label: Text('Submit'),
                  onPressed: () {
                    addList(controller.text);
                  },
                ),
                RaisedButton.icon(
                  color: Colors.red.shade700,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  icon: Icon(Icons.clear),
                  label: Text('Clear'),
                  onPressed: () {
                    clearList();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getList();
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(height: MediaQuery.of(context).padding.top),
            controlPanel(),
            Expanded(
              child: ListView(
                controller: listViewController,
                reverse: true,
                children: inputData == null
                    ? []
                    : inputData.map(
                        (data) {
                          return Dismissible(
                            key: Key(data['aka']),
                            onDismissed: (direction) {
                              updateList(data['aka']);
                            },
                            child: Material(
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: AssetImage(
                                    data['hero_img_path'],
                                  ),
                                ),
                                title: Text(data['hero_name']),
                                subtitle: Text(
                                    data['hero_type'].toString().toUpperCase()),
                              ),
                            ),
                          );
                        },
                      ).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
