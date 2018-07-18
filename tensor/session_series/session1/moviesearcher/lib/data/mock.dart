import 'dart:async';

import 'package:flutter/foundation.dart';

import 'movie.dart';

class MovieMockRepository extends MovieRepository {
  @override
    Future<Movies> fetchMovies(int pageNumber) async {
      // TODO: implement fetchMovies
      print('Movie mocking called');
      return compute(createMovies, 100);
    }
}

Movies createMovies(int x) {
  return Movies(
    page: 2,
    totalPages: 10,
    totalResult: 100,
    movies: List<Movie>.generate(x, (int i) {
      return Movie(
        title: "Deadpool $i",
        posterPath: "/\c9XxwwhPHdaImA2f1WEfEsbhaFB.jpg",
        id: i.toString(),
        overview: "Jurasic World movie is awesome!",
        voteAverage: "4.5"
      );
    })
  );
}