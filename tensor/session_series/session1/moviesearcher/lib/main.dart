import 'package:flutter/material.dart';

import 'data/movie.dart';
import 'commonWidget/placeholder_content.dart';
import 'ui/movie_list_tile.dart';
import 'dependencies_injection.dart';

final Injector injector = Injector();
const int FIRST_PAGE_MOVIE = 1;
var function = (String msg) => '!!!${msg.toUpperCase()}!!!';

void main() {
  Injector.configure(Flavor.PROD);
  runApp(MovieSearcherApp());
}

class MovieSearcherApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Movie Searcher',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          brightness: Brightness.dark,
          accentColor: Colors.redAccent
        ),
        home: HomePage(),
      );
    }
}

class HomePage extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('Movie Searcher', textDirection: TextDirection.ltr),
        ),
        body: MoviePage(),
      );
    }
}

class MoviePage extends StatefulWidget {
  @override
    _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  _tryAgainButtonClick(bool _) => setState(() {});
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return FutureBuilder<Movies>(
        future: injector.movieRepository.fetchMovies(FIRST_PAGE_MOVIE),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return PlaceholderContent(
              title: 'Something wrong occured.',
              message: 'Internet not connect. Please try again.',
              tryAgainButton: _tryAgainButtonClick,
            );
          }

          switch(snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              return MovieTile(
                movies: snapshots.data,
              );
            default:
          }
        },
      );
    }
}

class MovieTile extends StatefulWidget {
  final Movies movies;

  MovieTile({Key key, this.movies}) : super(key: key);

  @override
    _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  MovieLoadMoreStatus loadMoreStatus = MovieLoadMoreStatus.STABLE;
  final ScrollController scrollController = ScrollController();
  static const String IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/w500';
  List<Movie> movies;
  int currentPageNumber;

  var meg = function("hello");

  @override
    void initState() {
      // TODO: implement initState
      movies = widget.movies.movies;
      currentPageNumber = widget.movies.page;
      super.initState();
    }

  @override
    void dispose() {
      // TODO: implement dispose
      scrollController.dispose();
      super.dispose();
    }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
        scrollController.position.maxScrollExtent - scrollController.offset <= 50) {
          if (loadMoreStatus != null && loadMoreStatus == MovieLoadMoreStatus.STABLE) {
            loadMoreStatus = MovieLoadMoreStatus.LOADING;
            injector.movieRepository
              .fetchMovies(currentPageNumber + 1)
              .then((moviesObject) {
                currentPageNumber = moviesObject.page;
                loadMoreStatus = MovieLoadMoreStatus.STABLE;
                setState(() { movies.addAll(moviesObject.movies); });
              });
          }
        }
    }

    return true;
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return NotificationListener(
        onNotification: onNotification,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85
          ),
          controller: scrollController,
          itemCount: movies.length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (_, index) => MovieTileList(movie: movies[index])
        ),
      );
    }
}