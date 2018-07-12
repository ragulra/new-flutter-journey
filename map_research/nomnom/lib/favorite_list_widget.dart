import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'favorite.dart';
import 'favorite_manager.dart';

class FavoriteListWidget extends StatefulWidget {
  final FavoriteManager manager;

  FavoriteListWidget({@required this.manager}) : assert(manager != null);

  @override
    _FavoriteListWidgetState createState() => _FavoriteListWidgetState();
}

class _FavoriteListWidgetState extends State<FavoriteListWidget> {
  List<Favorite> _favorites;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _favorites = widget.manager.favorites;
      widget.manager.onFavoritesChanged.listen((_) {
        setState(() => _favorites = widget.manager.favorites);
      });
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      if (_favorites == null || _favorites.length == 0) {
        return Center(
          child: Text('You have no favorites.'),
        );
      }

      return ListView.builder(
        itemCount: _favorites.length,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          return new FavoriteCard(_favorites[index]);
        },
      );
    }
}

class FavoriteCard extends StatelessWidget {
  final Favorite favorite;

  FavoriteCard(this.favorite);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(
        padding: const EdgeInsets.only(top: 12.0),
        child: Card(
          elevation: 3.0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    favorite.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(favorite.address),
                Container(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Image.network(favorite.staticMapUrl),
                )
              ],
            ),
          ),
        ),
      );
    }
}