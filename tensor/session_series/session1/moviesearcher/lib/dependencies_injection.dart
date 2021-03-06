import 'data/movie.dart';
import 'data/mock.dart';
import 'data/prod.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _instance = Injector.internal();
  static Flavor _flavor;
  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() => _instance;

  Injector.internal();

  MovieRepository get movieRepository {
    switch(_flavor) {
      case Flavor.MOCK:
        return MovieMockRepository();
      default:
        return MovieProdRepository();
    }
  }
}

class Logger {
  final String name;
  bool mute = false;

  String get nameVar => name.toUpperCase();
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}