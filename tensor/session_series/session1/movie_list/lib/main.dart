import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const String apiKey = 'cbce471';
const String movieApiUrl = 'http://www.omdbapi.com/';

void main() {
  runApp(
    MaterialApp(
      title: 'Movie Finder',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.green
      ),
      home: MovieFinder(),
    )
  );
}

class MovieFinder extends StatefulWidget {
  @override
    _MovieFinder createState() => _MovieFinder();
}

class _MovieFinder extends State<MovieFinder> with TickerProviderStateMixin {
  final List<MovieItem> _movies = <MovieItem>[];
  Map moviedata;
  final TextEditingController _textController = TextEditingController();
  bool _isWriting = false;

  Future<String> getMovie(String title) async {
    var res = await http.get(Uri.encodeFull(movieApiUrl+'?apikey='+apiKey+'&t='+title));

    setState(() {
      moviedata = json.decode(res.body);
    });

    return 'Success fetch the movie';
  }

  Future<Null> _submitTitle(String title) async {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    await getMovie(title);
    MovieItem movie = MovieItem(
      title: moviedata['Title'],
      year: moviedata['Year'],
      released: moviedata['Released'],
      genre: moviedata['Genre'],
      writer: moviedata['Writer'],
      country: moviedata['Country'],
      director: moviedata['Director'],
      actors: moviedata['Actors'],
      plot: moviedata['Plot'],
      controller: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
      ),
    );
    setState(() {
      _movies.insert(0, movie);
    });
    movie.controller.forward();
  }

  Widget _buildFinder() {
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context).accentColor
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isWriting = text.length > 0;
                  });
                },
                onSubmitted: _submitTitle,
                decoration: InputDecoration.collapsed(
                  hintText: 'Enter title...'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3.0),
              child: IconButton(
                onPressed: _isWriting ? () => _submitTitle(_textController.text) : null,
                icon: Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
    void dispose() {
      // TODO: implement dispose
      for(MovieItem movieItem in _movies) {
        movieItem.controller.dispose();
      }
      super.dispose();
    }
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('Movie Finder'),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemBuilder: (_, int index) => _movies[index],
                itemCount: _movies.length,
                reverse: true,
                padding: EdgeInsets.all(8.0),
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor
              ),
              child: _buildFinder(),
            )
          ],
        ),
      );
    }
}

class MovieItem extends StatelessWidget {
  final String title;
  final String year;
  final String released;
  final String genre;
  final String writer;
  final String country;
  final String director;
  final String actors;
  final String plot;
  final AnimationController controller;
  MovieItem({
    this.title,
    this.year,
    this.released,
    this.genre,
    this.writer,
    this.country,
    this.director,
    this.actors,
    this.plot,
    this.controller
  }) : assert(title != null),
       assert(year != null),
       assert(released != null),
       assert(genre != null),
       assert(writer != null),
       assert(country != null),
       assert(director != null),
       assert(actors != null),
       assert(plot != null),
       assert(controller != null);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut
        ),
        axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all()
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Title: ',
                 style: TextStyle(
                   fontWeight: FontWeight.bold
                 )
                ),
                new Padding(padding: const EdgeInsets.only(right: 4.0)),
                Flexible(child:Text(title))]
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Year: ',
                 style: TextStyle(
                   fontWeight: FontWeight.bold
                 )
                ), 
                new Padding(padding: const EdgeInsets.only(right: 4.0)),
                Flexible(child:Text(year))]
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Released: ',
                 style: TextStyle(
                   fontWeight: FontWeight.bold
                 )
                ), 
                new Padding(padding: const EdgeInsets.only(right: 4.0)),
                Flexible(child:Text(released))]
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Genre: ',
                 style: TextStyle(
                   fontWeight: FontWeight.bold
                 )
                ), 
                new Padding(padding: const EdgeInsets.only(right: 4.0)),
                Flexible(child:Text(genre))]
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Country: ',
                 style: TextStyle(
                   fontWeight: FontWeight.bold
                 )
                ), 
                new Padding(padding: const EdgeInsets.only(right: 4.0)),
                Flexible(child:Text(country))]
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Director: ',
                 style: TextStyle(
                   fontWeight: FontWeight.bold
                 )
                ), 
                new Padding(padding: const EdgeInsets.only(right: 4.0)),
                Flexible(child:Text(director))]
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, 
              children: <Widget>[
                Text('Actors: ',
                 style: TextStyle(
                   fontWeight: FontWeight.bold
                 )
                ), 
                new Padding(padding: const EdgeInsets.only(right: 4.0)),
                Flexible(child:Text(actors))]
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, 
              children: <Widget>[
                Text('Plot: ',
                 style: TextStyle(
                   fontWeight: FontWeight.bold
                 )
                ), 
                new Padding(padding: const EdgeInsets.only(right: 4.0)),
                Flexible(child:Text(plot))]
              ),
            ],
          ),
        ),
      );
    }
}