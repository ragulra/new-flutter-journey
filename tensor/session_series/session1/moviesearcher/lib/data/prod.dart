import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'movie.dart';

const MOVIE_API_KEY = '86b09f4202d3d95563fc37f7b4636bf2';
const BASE_URL = 'https://api.themoviedb.org/3/movie/';

class MovieProdRepository implements MovieRepository {
  @override
    Future<Movies> fetchMovies(int pageNumber) async {
      // TODO: implement fetchMovies
      http.Response response = await http.get(
        BASE_URL + "popular?api_key="+
        MOVIE_API_KEY+"&page="+pageNumber.toString()
      );
      return compute(parseMovies, response.body);
    }
}

Movies parseMovies(String responseBody) {
  final Map moviesMap = JsonCodec().decode(responseBody);
  print(moviesMap);
  Movies movies = Movies.fromMap(moviesMap);
  if (movies == null) {
    throw new FetchMovieException("An error occured : [ Status Code = ]");
  }
  return movies;
}