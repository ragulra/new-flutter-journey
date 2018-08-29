import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:random_wallpaper/data/wallpaper.dart';

const ACCESS_KEY = '<put your key>';

class WallpaperProdRepository implements WallpaperRepository {
  @override
  Future<Wallpapers> fetchWallpapers(int pageNumber) async {
    // TODO: implement fetchWallpapers
    http.Response res = await http
        .get('https://api.pexels.com/v1/curated?per_page=10&page=$pageNumber', headers: {HttpHeaders.authorizationHeader: ACCESS_KEY});

    return compute(parseWallpapers, res.body);
  }
}

Wallpapers parseWallpapers(String res) {
  final Map wallpaperMap = JsonCodec().decode(res);
  print(wallpaperMap);
  Wallpapers wallpapers = Wallpapers.fromMap(wallpaperMap);
  if (wallpapers == null)
    throw new FetchWallpaperException('An error occured : [ Status Code = ]');

  return wallpapers;
}
