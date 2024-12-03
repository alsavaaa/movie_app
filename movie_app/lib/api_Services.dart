import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://imdb-top-100-movies.p.rapidapi.com/top32';
  static const Map<String, String> _headers = {
    'x-rapidapi-host': 'imdb-top-100-movies.p.rapidapi.com',
    'x-rapidapi-key': '0a04dff5eemsh250611bf07308b0p1b7c86jsnfa90d771d8d4',
  };

  /// Fetches movies data from the API.
  /// Throws an [Exception] if the request fails.
  static Future<List<Map<String, dynamic>>> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl), headers: _headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((movie) => movie as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to fetch movies. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('An error occurred while fetching movies: $error');
    }
  }
}
