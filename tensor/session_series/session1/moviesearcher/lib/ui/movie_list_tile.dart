import 'package:flutter/material.dart';

import '../network/image.dart';
import '../data/movie.dart';

const String IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/w500';

class MovieTileList extends StatelessWidget {
  final Movie movie;

  MovieTileList({this.movie});

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))
        ),
        color: Colors.white,
        elevation: 5.0,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: NetworkImageWithRetry(
                IMAGE_BASE_URL + movie.posterPath,
                scale: 0.85
              ),
              fit: BoxFit.fill,
            ),
            MovieFavoredImage(movie: movie),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 5.0,
                  right: 5.0
                ),
                child: Text('Rating: ${movie.voteAverage}'),
              ),
            )
          ],
        ),
      );
    }
}

class MovieFavoredImage extends StatefulWidget {
  final Movie movie;

  MovieFavoredImage({@required this.movie});

  @override
    _MovieFavoredImageState createState() => _MovieFavoredImageState();
}

class _MovieFavoredImageState extends State<MovieFavoredImage> {
  Movie currentMovie;

  @override
    void initState() {
      // TODO: implement initState
      currentMovie = widget.movie;
      super.initState();
    }

  onFavoredImagePressed() {
    setState(() => currentMovie.favored = !currentMovie.favored);
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(currentMovie.favored ? Icons.star : Icons.star_border),
            onPressed: onFavoredImagePressed,
          ),
        ),
      );
    }
}