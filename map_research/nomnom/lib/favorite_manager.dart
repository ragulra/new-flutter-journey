import 'dart:async';

import 'favorite.dart';

class FavoriteManager {
  List<Favorite> _favorites = [];
  StreamController _favStreamController = StreamController<List<Favorite>>.broadcast();

  Stream<List<Favorite>> get onFavoritesChanged => _favStreamController.stream;

  List<Favorite> get favorites => _favorites;

  void addFavorite(Favorite fav) {
    _favorites.add(fav);
    _favStreamController.add(_favorites);
  }

  void removeFavorite(Favorite fav) {
    _favorites.remove(fav);
    _favStreamController.add(_favorites);
  }
}