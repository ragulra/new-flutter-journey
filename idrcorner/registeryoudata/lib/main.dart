import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Register Your Data',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(0xFF22e045),
      accentColor: Color(0xFF9a0ef0),
    ),
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  List<String> _status = [
    'Single',
    'Married',
    'Forever Alone',
    'FriendZone',
    'Impossible',
    'In relationship'
  ];

  String status = 'Single';
  String sex = '';

  void _showTheData(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('First name: ' + firstNameController.text),
                  Text('Last name: ' + lastNameController.text),
                  Text('Age: ' + ageController.text),
                  Text('Address: ' + addressController.text),
                  Text('Gender: ' + sex),
                  Text('Status: ' + status),
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    label: Text('Back'),
                    icon: Icon(Icons.arrow_back),
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          );
        });
  }

  void _chooseReligion(String value) {
    setState(() {
      status = value;
    });
  }

  void _chooseSex(String value) {
    setState(() {
      sex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Your Data'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
        children: <Widget>[
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(
                labelText: 'First Name',
                labelStyle: TextStyle(fontSize: 10.0),
                hintText: 'First Name',
                hintStyle: TextStyle(fontSize: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0))),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 8.0)),
          TextField(
            controller: lastNameController,
            decoration: InputDecoration(
                labelText: 'Last Name',
                hintText: 'Last Name',
                labelStyle: TextStyle(fontSize: 10.0),
                hintStyle: TextStyle(fontSize: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0))),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 8.0)),
          TextField(
            keyboardType: TextInputType.number,
            controller: ageController,
            maxLength: 2,
            decoration: InputDecoration(
                labelText: 'Age',
                hintText: 'Age',
                labelStyle: TextStyle(fontSize: 10.0),
                hintStyle: TextStyle(fontSize: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0))),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 8.0)),
          TextField(
            keyboardType: TextInputType.number,
            controller: addressController,
            maxLines: 5,
            decoration: InputDecoration(
                labelText: 'Address',
                labelStyle: TextStyle(fontSize: 10.0),
                hintText: 'Address',
                hintStyle: TextStyle(fontSize: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0))),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 8.0)),
          RadioListTile(
            value: 'male',
            title: Text('Male'),
            groupValue: sex,
            onChanged: (String value) {
              _chooseSex(value);
            },
            activeColor: Theme.of(context).accentColor,
            subtitle: Text('Choose this if you are a male.'),
          ),
          RadioListTile(
            value: 'female',
            title: Text('Female'),
            groupValue: sex,
            onChanged: (String value) {
              _chooseSex(value);
            },
            activeColor: Theme.of(context).accentColor,
            subtitle: Text('Choose this if you are a female.'),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 8.0)),
          Row(
            children: <Widget>[
              Text('Status : '),
              Padding(padding: const EdgeInsets.only(right: 10.0)),
              DropdownButton(
                  onChanged: (String value) {
                    _chooseReligion(value);
                  },
                  value: status,
                  items: _status.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList())
            ],
          ),
          Padding(padding: const EdgeInsets.only(bottom: 8.0)),
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)
            ),
            onPressed: () => _showTheData(context),
            icon: Icon(Icons.send),
            label: Text('Send'),
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
