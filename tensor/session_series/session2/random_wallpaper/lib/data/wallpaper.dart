import 'dart:async';

enum WallpaperLoadMoreStatus {
  LOADING,
  STABLE,
}

class Wallpaper {
  final int id;
  final int width;
  final int height;
  final String takenBy;
  final String imageURL;

  Wallpaper({
    this.id,
    this.width,
    this.height,
    this.takenBy,
    this.imageURL,
  });

  factory Wallpaper.fromJson(Map map) {
    return Wallpaper(
        id: map['id'],
        width: map['width'],
        height: map['height'],
        takenBy: map['photographer'],
        imageURL: map['src']['portrait']);
  }
}

class Wallpapers {
  final int page;
  final int perpage;
  final List<Wallpaper> wallpapers;
  final String nextPageUrl;

  Wallpapers({
    this.page,
    this.perpage,
    this.wallpapers,
    this.nextPageUrl,
  });

  call(String a, String b) => '$a $b';

  Wallpapers.fromMap(Map<String, dynamic> value)
      : page = value['page'],
        perpage = value['per_page'],
        wallpapers = List<Wallpaper>.from(
          value['photos'].map(
            (wallpaper) => Wallpaper.fromJson(wallpaper),
          ),
        ),
        nextPageUrl = value['next_page'];
}

abstract class WallpaperRepository {
  Future<Wallpapers> fetchWallpapers(int pageNumber);
}

class FetchWallpaperException implements Exception {
  final _message;

  FetchWallpaperException([this._message]);

  String toString() {
    if (_message == null) return 'Exception';
    return 'Exception: $_message';
  }
}
