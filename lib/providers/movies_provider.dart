import 'dart:convert';

import 'package:apppeliculas_p63/Models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier{
  String _apiKey = 'af5b9f53999b8dcb355caeb92119822e';
  String _baseURL = 'api.themoviedb.org';
  String _lenguaje = 'es-ES';
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int,List<Cast>> moviesCast = {};
  int nPage = 0;

  MoviesProvider() {
    print('Movies Provider-p63 Inicializado');
    getOnDisplayMovies();
    getPopularMovies();
  }
  getPopularMovies() async {
    nPage++;
    var url = Uri.https(_baseURL, '3/movie/popular',
        {'page': nPage.toString(), 'api_key': _apiKey, 'language': _lenguaje});
    //print('url:');
    //print(url.toString());
    final response = await http.get(url);
    if (response.statusCode != 200) return print('***********Error en Popular*********');
    final decodedData = json.decode(response.body);
    final decodeData = PopularResponse.fromJson(decodedData);
    popularMovies = [...popularMovies,...decodeData.movies];
    print(popularMovies[0]);
    notifyListeners();
    //print(decodeData.movies[0].title);
  }

  getOnDisplayMovies() async {
    
    final jsonData = await _getJsonData('3/movie/now_playing');
    final decodedData = json.decode(jsonData);
    final decodeData=NowPlayingResponse.fromJson(decodedData);
    onDisplayMovies = decodeData.movies;
    notifyListeners();
    //print(decodeData.movies[0].title);
  }

  getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final List<Cast> castList = CreditsResponse.fromJson(json.decode(jsonData)).cast; // Decodificar la cadena JSON
    moviesCast[movieId] = castList;
    return castList;
  }

  // Future<List<Movie>> searchMovies(String query) async {
  //   var url = Uri.http(_baseURL, '3/search/movie',
  //   {'api_key': _apiKey, 'language': _lenguaje, 'query': query});
  //   final response = await http.get(url);
  //   final searchResponse = SearchResponse.fromJson(response.body);
  //   return searchResponse.results;
  // }
  Future<List<Movie>> searchMovies(String query) async {
  var url = Uri.http(_baseURL, '3/search/movie',
      {'api_key': _apiKey, 'language': _lenguaje, 'query': query});
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final searchResponse = SearchResponse.fromJson(jsonResponse);
    return searchResponse.results;
  } else {
    throw Exception('Failed to load search results');
  }
}

  Future<String> _getJsonData(String endpoint,[int page=1]) async {
    var url = Uri.http(_baseURL, endpoint,
      {'page': '$page', 'api_key': _apiKey, 'language': _lenguaje});
    final response = await http.get(url);
    return response.body;
  }
}

