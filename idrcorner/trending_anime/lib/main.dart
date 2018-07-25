import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const URL = 'https://kitsu.io/api/edge/trending/anime';

void main() {
  _getTrendingAnimes().then((data) {
    runApp(
      MaterialApp(
        title: 'Trending Anime',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.redAccent
        ),
        home: HomePage(trendingAnimes: data),
      )
    );
  });
}

Future _getTrendingAnimes() async {
  var res = await http.get(Uri.encodeFull(URL));

  return json.decode(res.body)['data'];
}

class HomePage extends StatefulWidget {
  final List trendingAnimes;

  HomePage({@required this.trendingAnimes});

  @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('Trending Anime'),
          centerTitle: true,
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
          ),
          itemCount: widget.trendingAnimes.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Hero(
                      tag: widget.trendingAnimes[index]['id'],
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      title: Text('Detail'),
                                      centerTitle: true,
                                    ),
                                    body: ListView(
                                      children: <Widget>[
                                        Hero(
                                          tag: widget.trendingAnimes[index]['id'],
                                          child: Material(
                                            child: InkWell(
                                              child: Image.network(
                                                widget.trendingAnimes[index]['attributes']['posterImage']['original'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Text(
                                            widget.trendingAnimes[index]['attributes']['titles']['en_jp'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.0
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.favorite, size: 50.0, color: Colors.red),
                                                Text(widget.trendingAnimes[index]['attributes']['favoritesCount'].toString())
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.rate_review, size: 50.0, color: Colors.teal),
                                                Text(widget.trendingAnimes[index]['attributes']['averageRating'])
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('SYNOPSIS', style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 15.0
                                              )),
                                              Text(
                                                widget.trendingAnimes[index]['attributes']['synopsis'],
                                                textAlign: TextAlign.justify,
                                              ),
                                            ],
                                          )
                                        )
                                      ],
                                    ),
                                  );
                                }
                              )
                            );
                          },
                          child: Image.network(
                            widget.trendingAnimes[index]['attributes']['posterImage']['original'],
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Expanded(child: Container()),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: 2.0
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.elliptical(50.0, 25.0)
                            )
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            widget.trendingAnimes[index]['attributes']['titles']['en_jp'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 10.0
                            ),
                          )
                        )
                      ],
                    )
                  ],
                ),
              )
            );
          },
        )
      );
    }
}