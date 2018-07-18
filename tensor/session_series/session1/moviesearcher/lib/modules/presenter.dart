import '../data/movie.dart';
import '../dependencies_injection.dart';

abstract class MovieListViewContract {
  void onMovies(List<Movie> movies);
  void onLoadMoviesError();
}

class MovieListPresenter {
  final MovieListViewContract movieListViewContract;
  MovieRepository movieRepository;

  MovieListPresenter(this.movieListViewContract) {
    movieRepository = Injector().movieRepository;
  }

  void loadMovies() {
    movieRepository
      .fetchMovies(1)
      .then((movies) => movieListViewContract.onMovies(movies.movies))
      .catchError((onError) => movieListViewContract.onLoadMoviesError());
  }
}