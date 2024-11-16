import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:movie_hub/models/actor_model.dart';
import 'package:movie_hub/models/movie_model.dart';

class ApiServices {
  final String apiKey = dotenv.env['API_KEY'] ?? 'API_KEY not found';
  final propularMovies = 'https://api.themoviedb.org/3/movie/popular?api_key=';
  final nowPlaying = 'https://api.themoviedb.org/3/movie/now_playing?api_key=';
  final topRatedMovies =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=';
  final upcomingMovies = 'https://api.themoviedb.org/3/movie/upcoming?api_key=';
  final movieData = 'https://api.themoviedb.org/3/movie/';
  final cast = 'https://api.themoviedb.org/3/movie/';

  Future<List<MovieModel>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$propularMovies$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies = results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();

      return movies;
    } else {
      Logger().e('Error - ${response.statusCode}');
      return [];
    }
  }

  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse('$nowPlaying$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies = results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
      return movies;
    } else {
      Logger().e('Error - ${response.statusCode}');
      return [];
    }
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse('$topRatedMovies$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies = results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
      return movies;
    } else {
      Logger().e('Error - ${response.statusCode}');
      return [];
    }
  }

  Future<List<MovieModel>> getupcomingMovies() async {
    final response = await http.get(Uri.parse('$upcomingMovies$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies = results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
      return movies;
    } else {
      Logger().e('Error - ${response.statusCode}');
      return [];
    }
  }

  Future<MovieModel?> getMovieDetails(int id) async {
    final response = await http.get(Uri.parse('$movieData$id?api_key=$apiKey'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      MovieModel movie = MovieModel.fromJson(body);
      return movie;
    } else {
      Logger().e('Error - ${response.statusCode}');
      return null;
    }
  }

  Future<List<ActorModel>> getCast(int id) async {
    final response =
        await http.get(Uri.parse('$cast$id/credits?api_key=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> cast = body['cast'];
      List<ActorModel> actors = cast
          .map((actor) => ActorModel.fromJson(actor as Map<String, dynamic>))
          .toList();
      return actors;
    } else {
      Logger().e('error - ${response.statusCode}');
      return [];
    }
  }
}
