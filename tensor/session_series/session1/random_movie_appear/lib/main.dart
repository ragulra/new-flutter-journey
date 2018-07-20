import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const Map<String, dynamic> requirements = {
  'apiUrl': 'https://api.themoviedb.org/3/movie/top_rated',
  'apiKey': '86b09f4202d3d95563fc37f7b4636bf2',
  'apiLang': 'en-US',
  'apiPage': 1,
  'imageUrl': 'https://image.tmdb.org/t/p/original'
};

void main() {
  getMovies().then((value) {
    runApp(
      MaterialApp(
        title: 'Random Movie Appear',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.pinkAccent
        ),
        home: RandomMovieAppearApp(value),
        debugShowCheckedModeBanner: false,
      )
    );
  });
}

Future<List<dynamic>> getMovies() async {
    var res = await http.get(Uri.encodeFull(requirements['apiUrl']+'?api_key='+requirements['apiKey']+'&language='+requirements['apiLang']+'&page='+requirements['apiPage'].toString()));
    var data = json.decode(res.body);
    var result = data['results'];

    return result;
  }

class RandomMovieAppearApp extends StatefulWidget {
  final List<dynamic> movies;
  
  RandomMovieAppearApp(this.movies);

  @override
    _RandomMovieAppearAppState createState() => _RandomMovieAppearAppState();
}

class _RandomMovieAppearAppState extends State<RandomMovieAppearApp> {
  final Random _random = Random();
  String urlImage;
  String title;
  String releaseDate;
  int index;
  Color color = Colors.red;

  void onTap() {
    setState(() {
      color = Color.fromRGBO(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextDouble());
      index = _random.nextInt(widget.movies.length - 1);
      urlImage = widget.movies[index]['poster_path'];
      title = widget.movies[index]['title'];
      releaseDate = widget.movies[index]['release_date'];
    });
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      urlImage = widget.movies[0]['poster_path'];
      title = widget.movies[0]['title'];
      releaseDate = widget.movies[0]['release_date'];
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MovieState(
        color: color,
        onTap: onTap,
        urlImage: urlImage,
        title: title,
        releaseDate: releaseDate,
        child: MoviePair(),
      );
    }
}

class MovieState extends InheritedWidget {
  final Color color;
  final Function onTap;
  final String urlImage;
  final String title;
  final String releaseDate;

  MovieState({
    Key key,
    this.color,
    this.onTap,
    this.urlImage,
    this.title,
    this.releaseDate,
    Widget child
  }) : super(key: key, child: child);

  @override
    bool updateShouldNotify(MovieState oldWidget) {
      // TODO: implement updateShouldNotify
      return color != oldWidget.color && title != oldWidget.title
          && urlImage != oldWidget.urlImage && releaseDate != oldWidget.releaseDate;
    }

  static MovieState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MovieState);
  }
}

class MoviePair extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'RANDOM MOVIE USING INHRITED WIDGET AND GESTURE',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
              Container(height: 20.0),
              OneMovie(),
              Container(height: 20.0),
              OneMovie()
            ],
          ),
        ),
      );
    }
}

class OneMovie extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      final state = MovieState.of(context);
      return GestureDetector(
        onTap: state.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: state.color,
            border: Border.all(),
            borderRadius: BorderRadius.circular(12.0)
          ),
          height: 200.0,
          width: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.network(
                requirements['imageUrl']+state.urlImage,
                height: 150.0,
              ),
              Text(state.title),
              Text(state.releaseDate)
            ],
          ),
        ),
      );
    }
}

class Movie {
  final String title;
  final String imageUrl;
  final String releaseDate;

  Movie.fromJson(Map map):
    title = map['title'],
    imageUrl = map['poster_path'],
    releaseDate = map['release_date'];
}