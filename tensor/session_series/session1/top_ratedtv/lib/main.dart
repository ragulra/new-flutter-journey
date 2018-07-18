import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const Map<String, dynamic> requirements = {
  'apiUrl': 'https://api.themoviedb.org/3/tv/top_rated',
  'apiKey': '86b09f4202d3d95563fc37f7b4636bf2',
  'apiLang': 'en-US',
  'apiPage': 1,
  'imageUrl': 'https://image.tmdb.org/t/p/original'
};

void main() {
  runApp(
    MaterialApp(
      title: 'Popular Actors',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.purple
      ),
      home: HomeScreen(),
    )
  );
}

class HomeScreen extends StatefulWidget {
  @override
    _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with SingleTickerProviderStateMixin{
  StreamController<Actor> streamController;
  List<Actor> actors = [];
  JsonDecoder decoder = JsonDecoder();
  TabController tabController;

  load(StreamController controller) async {
    var client = http.Client();
    var req = http.Request('get', Uri.parse(requirements['apiUrl']+'?api_key='+requirements['apiKey']+'&language='+requirements['apiLang']+'&page='+requirements['apiPage'].toString()));
    print(requirements['apiUrl']+'?api_key='+requirements['apiKey']+'&language='+requirements['apiLang']+'&page='+requirements['apiPage'].toString());
    var streamRes = await client.send(req);

    streamRes.stream
      .transform(utf8.decoder)
      .map((map) {
        //print(map);
        Map data = decoder.convert(map);
        print(data['results'][0]);
        return data['results'];
      })
      .expand((e) => e)
      .map((map) => Actor.fromJson(map))
      .pipe(streamController);
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      tabController = TabController(length: 2, vsync: this);
      streamController = StreamController.broadcast();
      streamController.stream.listen((actor) => setState(() => actors.add(actor)));

      load(streamController);
    }

  @override
    void dispose() {
      // TODO: implement dispose
      tabController.dispose();
      super.dispose();
      streamController?.close();
      streamController = null;
    }

  TabBar createTabBar() {
    return TabBar(
      tabs: <Widget>[
        Tab(
          icon: Icon(Icons.live_tv),
        ),
        Tab(
          icon: Icon(Icons.bookmark),
        )
      ],
      controller: tabController,
    );
  }

  TabBarView createTabBarView(List<Widget> tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  Widget makeGridCell(int index) {
    if (index > actors.length) {
      return null;
    }

    return Card(
      elevation: 1.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Image.network(requirements['imageUrl']+actors[index].imagePath),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              actors[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            )
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
          title: Text('Top Rated on TV'),
          bottom: createTabBar(),
        ),
        body: createTabBarView(
          <Widget>[
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
              ),
              primary: true,
              padding: EdgeInsets.all(1.0),
              itemBuilder: (BuildContext context, int index) => makeGridCell(index),
              itemCount: actors.length,
            ),
            SimpleStepper()
          ]
        )
      );
  }
}

class SimpleStepper extends StatefulWidget {
  @override
    _SimpleStepper createState() => _SimpleStepper();
}

class _SimpleStepper extends State<SimpleStepper> {
  int stepCounter = 0;
  List<Step> steps = [
    Step(
      title: Text('Get access token'),
      content: Text('Goto settings -> API -> and there you found your access token.'),
      isActive: true
    ),
    Step(
      title: Text('Access The API'),
      content: Text('In order to access the api you need to go to developer.themovidedb.com/3/'),
      isActive: true
    ),
    Step(
      title: Text('Enjoy'),
      content: Text('Now you can pick anything you want.'),
      isActive: true
    )
  ];

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(
        child: Stepper(
          currentStep: this.stepCounter,
          steps: steps,
          type: StepperType.vertical,
          onStepTapped: (step) {
            setState(() {
              stepCounter = step;
            });
          },
          onStepCancel: () {
            setState(() {
              stepCounter > 0 ? stepCounter -= 1 : stepCounter = 0;
            });
          },
          onStepContinue: () {
            setState(() {
              stepCounter < steps.length - 1 ? stepCounter += 1 : stepCounter = 0;
            });
          },
        ),
      );
    }
}

class Actor {
  final String name;
  final String imagePath;

  Actor.fromJson(Map map) :
    name = map['original_name'],
    imagePath = map['backdrop_path'];
}