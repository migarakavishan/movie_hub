import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:movie_hub/models/movie_model.dart';

class ApiServices {
  final apiKey = 'api_key=2058ec167f96bdbcd73b462bd88f128e';
  final propularMovies = 'https://api.themoviedb.org/3/movie/popular?';

  Future<List<MovieModel>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$propularMovies$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies = results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
      Logger().f(movies[0].posterPath);

      return movies;
    } else {
      Logger().e('Error - ${response.statusCode}');
      return [];
    }
  }
}
