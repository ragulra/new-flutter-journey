import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:random_wallpaper/data/wallpaper.dart';

class WallpaperMockRepository extends WallpaperRepository {
  @override
  Future<Wallpapers> fetchWallpapers(int pageNumber) async {
    // TODO: implement fetchWallpapers
    return compute(createWallpaper, 100);
  }
}

Wallpapers createWallpaper(int x) {
  return Wallpapers(
    page: 1,
    perpage: 15,
    wallpapers: List<Wallpaper>.generate(
      x,
      (int i) {
        return Wallpaper(
            id: 111111,
            height: 2000,
            width: 2000,
            takenBy: 'Ahmad Jamil Al Rasyid',
            imageURL: '');
      },
    ),
  );
}
