import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


void main() {
  runApp(
    MaterialApp(
      title: 'ListView Weight Tracker 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomeScreen(
        title: 'ListView Weight Tracker 1',
      ),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> strings = List();

  void _addWeightSave() {
    setState(() {
      strings.add('new string');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: strings.map((String value) {
          return Text(value);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWeightSave,
        tooltip: 'Add new weight entry',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class WeightSave {
  DateTime dateTime;
  double weight;

  WeightSave({
    this.dateTime,
    this.weight,
  });
}


