import 'package:random_wallpaper/data/wallpaper.dart';
import 'package:random_wallpaper/dependencies_injection.dart';

abstract class WallpaperListViewContract {
  void onWallpapers(List<Wallpaper> wallpaper);
  void onLoadWallpapersError();
}

class WallpaperListPresenter {
  final WallpaperListViewContract wallpaperListViewContract;
  WallpaperRepository wallpaperRepository;

  WallpaperListPresenter(this.wallpaperListViewContract) {
    wallpaperRepository = Injector().wallpaperRepository;
  }

  void loadWallpapers() {
    wallpaperRepository
        .fetchWallpapers(1)
        .then((wallpaper) =>
            wallpaperListViewContract.onWallpapers(wallpaper.wallpapers))
        .catchError(
            (onError) => wallpaperListViewContract.onLoadWallpapersError());
  }
}
