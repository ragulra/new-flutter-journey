import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final int index;
  final Map data;

  EditPage({@required this.data, this.index});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController _controllerAppName;
  TextEditingController _controllerTechnology;
  TextEditingController _controllerDescription;

  int _amountTime;

  List<String> category = [
    'Art & Desgin',
    'Auto & Vehicles',
    'Beauty',
    'Books & References',
    'Bussiness',
    'Comics',
    'Dating',
    'Communication'
  ];

  String _type;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Add Plan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controllerAppName,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  labelText: 'Application Name'),
            ),
            Row(
              children: <Widget>[
                Text('Category', style: TextStyle(color: Colors.grey)),
                SizedBox(width: 20.0),
                DropdownButton<String>(
                  value: _type == '' ? null : _type,
                  items: category.map((ctg) {
                    return DropdownMenuItem<String>(
                      value: ctg,
                      child: Text(ctg),
                    );
                  }).toList(),
                  onChanged: (ctg) {
                    setState(() {
                      _type = ctg;
                    });
                  },
                ),
              ],
            ),
            Text('Estimated Time', style: TextStyle(color: Colors.grey)),
            SizedBox(width: 10.0),
            RadioListTile<int>(
              value: 1,
              title: Text('1 Month'),
              groupValue: _amountTime,
              onChanged: (amount) {
                setState(() {
                  _amountTime = amount;
                });
              },
              activeColor: Theme.of(context).accentColor,
            ),
            RadioListTile<int>(
              value: 2,
              title: Text('2 Months'),
              groupValue: _amountTime,
              onChanged: (amount) {
                setState(() {
                  _amountTime = amount;
                });
              },
              activeColor: Theme.of(context).accentColor,
            ),
            RadioListTile<int>(
              value: 3,
              title: Text('3 Months'),
              groupValue: _amountTime,
              onChanged: (amount) {
                setState(() {
                  _amountTime = amount;
                });
              },
              activeColor: Theme.of(context).accentColor,
            ),
            TextField(
              controller: _controllerTechnology,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  labelText: 'Technology use'),
            ),
            TextField(
              maxLines: 4,
              controller: _controllerDescription,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  labelText: 'Description'),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Theme.of(context).accentColor,
              elevation: 0.0,
              onPressed: () {
                print('appname: ' + _controllerAppName.text);
                print('type: ' + _type);
                print('estimatedtime: ' + _amountTime.toString());
                print('technology: ' + _controllerTechnology.text);
                print('description: ' + _controllerDescription.text);

                _sendData();
                
                Navigator.of(context).pop();
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _type = widget.data['type'];
    _amountTime = int.parse(widget.data['estimated_time'][0]);
    _controllerAppName = TextEditingController(text: widget.data['app_name']);
    _controllerTechnology = TextEditingController(text: widget.data['technology']);
    _controllerDescription = TextEditingController(text: widget.data['description']);
    super.initState();
  }

  Future _sendData() async {
    var url = 'http://192.168.1.9/playstore_plan/editdata.php';
    /* only comment */

    http.post(
      url,
      body: {
        'id': widget.index.toString(),
        'app_name': _controllerAppName.text,
        'type': _type,
        'estimatedtime': _amountTime == 1
            ? _amountTime.toString() + ' month'
            : _amountTime.toString() + ' months',
        'technology_used': _controllerTechnology.text,
        'description': _controllerDescription.text
      },
    );
  }
}
