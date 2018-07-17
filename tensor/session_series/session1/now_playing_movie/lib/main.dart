import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


int page;
const Map<String, dynamic> data = {
  'apiUrl': 'https://api.themoviedb.org/3/movie/now_playing',
  'apiKey': '86b09f4202d3d95563fc37f7b4636bf2',
  'apiLang': 'en-US',
  'apiPage': 1,
  'imageUrl': 'https://image.tmdb.org/t/p/original'
};

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Now Playing Movie',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.red
      ),
      home: HomeScreen(),
    )
  );
}

class HomeScreen extends StatefulWidget {
  @override
    _HomeScreenState createState() =>  _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamController<Movie> streamController;
  List<Movie> movies = [];

  load(StreamController controller) async {
    var client = http.Client();
    var req = http.Request('get', Uri.parse(data['apiUrl']+'?api_key='+data['apiKey']+'&language='+data['apiLang']+'&page='+data['apiPage'].toString()));
    print(data['apiUrl']+'?api_key='+data['apiKey']+'&language='+data['apiLang']+'&page='+data['apiPage'].toString());
    var streamedRes = await client.send(req);
  
    streamedRes.stream
      .transform(utf8.decoder)
      //.transform(json.decoder)
      .map((map) {
        Map data = json.decode(map);

        // SharedPreferences.getInstance().then((SharedPreferences prefs) {
        //   prefs.setInt('nowPage', data['page']);
        //   prefs.setInt('totalPage', data['total_pages']);
        // });

        return data['results'];
      })
      .expand((e) {
        //print(e.toString());
        return e;
      })
      .map((map) => Movie.fromJson(map))
      .pipe(streamController);
  }

  // Future<Null> anotherPage() async {
  //   setState(() {
  //     SharedPreferences.getInstance().then((SharedPreferences prefs) {
  //       setState(() {
  //         page = prefs.getInt('nowPage') + 1;
  //         load(streamController, page);
  //       });
  //     });
  //   });
  // }

  @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      streamController?.close();
      streamController = null;
    }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      streamController = StreamController.broadcast();
      streamController.stream.listen((movie) => setState(() => movies.add(movie)));

      load(streamController);
    }

  Widget _makeElement(int index) {
    if (index > movies.length) {
      return null;
    }

    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.network(data['imageUrl']+movies[index].imageUrl, height: 170.0),
          Padding(padding: const EdgeInsets.only(right: 4.0)),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  movies[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0
                  ),
                ),
                Padding(padding: const EdgeInsets.only(bottom: 6.0)),
                Text(
                  movies[index].overview,
                  textAlign: TextAlign.justify,
                ),
                Padding(padding: const EdgeInsets.only(bottom: 6.0)),
                Text('Release Date: '+movies[index].releaseDate)
              ],
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
          title: Text('Now Playing Movie'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _makeElement(index);
          },
          itemCount: movies.length,
        ),
        // Column(
        //   children: <Widget>[
        //     Flexible(
        //       child: 
        //     ),
        //     RaisedButton(
        //       onPressed: () {
        //         SharedPreferences.getInstance().then((SharedPreferences prefs) {
        //           if (page != prefs.getInt('totalPage')) {
        //             anotherPage();
        //           } else {
        //             setState(() {
        //               page = 1;
        //             });
        //           }
        //         });
        //       },
        //       child: Text('Get more movie', style: TextStyle(color: Colors.white)),
        //       color: Theme.of(context).primaryColor,
        //       highlightColor: Theme.of(context).primaryColor,
        //       splashColor: Theme.of(context).accentColor,
        //     ),
        //   ],
        // )
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //       SharedPreferences.getInstance().then((SharedPreferences prefs) {
        //         if (page != prefs.getInt('totalPage')) {
        //           anotherPage();
        //         } else {
        //           setState(() {
        //             page = 1;
        //           });
        //         }
        //       });
        //   },
        //   child: Icon(Icons.refresh),
        // ),
      );
    }
}

class Movie {
  final String title;
  final String imageUrl;
  final String overview;
  final String releaseDate;

  Movie.fromJson(Map map) :
    title = map['title'],
    imageUrl = map['poster_path'],
    overview = map['overview'],
    releaseDate = map['release_date'];
}