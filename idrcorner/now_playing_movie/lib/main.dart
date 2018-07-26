import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const URL =
    'https://api.themoviedb.org/3/movie/now_playing?api_key=86b09f4202d3d95563fc37f7b4636bf2&language=en-US';

void main() {
  _getNowPlayingMovie().then((data) {
    runApp(MaterialApp(
      title: 'Now Playing Movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(dataMovie: data),
    ));
  });
}

Future<List<dynamic>> _getNowPlayingMovie() async {
  var res = await http.get(Uri.encodeFull(URL));

  return json.decode(res.body)['results'];
}

class HomeScreen extends StatefulWidget {
  final List<dynamic> dataMovie;

  HomeScreen({@required this.dataMovie});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [Colors.black, Colors.red])),
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.9),
          itemCount: widget.dataMovie.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: MediaQuery.of(context).padding.top),
                child: Material(
                    borderRadius: BorderRadius.circular(12.0),
                    elevation: 4.0,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Hero(
                          tag: widget.dataMovie[index]['id'],
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return DetailScreen(
                                    id: widget.dataMovie[index]['id'],
                                    title: widget.dataMovie[index]['title'],
                                    popularity: widget.dataMovie[index]
                                        ['popularity'],
                                    rating: double.parse(widget.dataMovie[index]['vote_average'].toString()),
                                    synopsis: widget.dataMovie[index]
                                        ['overview'],
                                    imageUrl: widget.dataMovie[index]
                                        ['poster_path'],
                                  );
                                }));
                              },
                              child: Image.network(
                                  'https://image.tmdb.org/t/p/original' +
                                      widget.dataMovie[index]['poster_path'],
                                  fit: BoxFit.cover),
                            ),
                          ),
                        )
                      ],
                    )));
          },
        ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final int id;
  final String title;
  final double popularity;
  final double rating;
  final String synopsis;
  final String imageUrl;

  DetailScreen({
    @required this.id,
    @required this.title,
    @required this.popularity,
    @required this.rating,
    @required this.synopsis,
    @required this.imageUrl,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int triggred = 0;

  void _showOrNotDetails(int value) {
    switch (value) {
      case 0:
        setState(() {
          triggred = 1;
        });
        break;
      case 1:
        setState(() {
          triggred = 0;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: _showOrNotDetails,
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<int>>[
                PopupMenuItem(
                  value: 0,
                  child: Text('Show Sinopsis'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('Hide Sinopsis'),
                ),
              ];
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: widget.id,
            child: Material(
              child: Image.network(
                  'https://image.tmdb.org/t/p/original' + widget.imageUrl,
                  height: 400.0,
                  width: 400.0),
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 12.0)),
          Column(
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              Padding(padding: const EdgeInsets.only(bottom: 12.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text(
                      widget.rating.toString(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.favorite, color: Colors.red),
                      Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                      Text(widget.popularity.toString())
                    ],
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: triggred == 1
                      ? Text(
                          widget.synopsis,
                          textAlign: TextAlign.justify,
                        )
                      : Text(''))
            ],
          )
        ],
      ),
    );
  }
}
