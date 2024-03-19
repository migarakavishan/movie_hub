import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiServices {
  final apiKey = 'api_key=2058ec167f96bdbcd73b462bd88f128e';
  final propularMovies = 'https://api.themoviedb.org/3/movie/popular?';

  Future<void> getPopularMovies() async {
    final response = await http.get(Uri.parse('$propularMovies$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      Logger().f(results.length);
    } else {
      Logger().e('Error - ${response.statusCode}');
    }
  }
}
