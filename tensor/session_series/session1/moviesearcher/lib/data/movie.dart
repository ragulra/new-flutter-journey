import 'dart:async';

enum MovieLoadMoreStatus { LOADING, STABLE }

class Movie {
  final String title;
  final String posterPath;
  final String id;
  final String overview;
  final String voteAverage;
  bool favored;

  Movie({
    this.title,
    this.posterPath,
    this.id,
    this.overview,
    this.voteAverage,
    this.favored
  });

  factory Movie.fromJson(Map value) {
    return Movie(
      title: value['title'],
      posterPath: value['poster_path'],
      id: value['id'].toString(),
      overview: value['overview'],
      voteAverage: value['vote_average'].toString(),
      favored: false
    );
  }
}

class Movies {
  final int page;
  final int totalResult;
  final int totalPages;
  final List<Movie> movies;

  Movies({
    this.page,
    this.totalResult,
    this.totalPages,
    this.movies
  });

  call(String a, String b) => '$a $b';

  Movies.fromMap(Map<String, dynamic> value)
    : page = value['page'],
      totalResult = value['total_results'],
      totalPages = value['total_pages'],
      movies = List<Movie>.from(
        value['results'].map((movie) => Movie.fromJson(movie))
      );
}

abstract class MovieRepository {
  Future<Movies> fetchMovies(int pageNumber);
}

class FetchMovieException implements Exception {
  final _message;

  FetchMovieException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}