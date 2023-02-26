import 'dart:convert';
import 'package:refilmer/data/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:refilmer/data/repositories/movie_repository_interface.dart';

class MovieRepository implements IMovieRepository {
  final http.Client httpClient;
  final String apiKey;

  MovieRepository({required this.httpClient, required this.apiKey});

  @override
  Future<List<Movie>> getMovies(int page) async {
    String url =
        'https://api.themoviedb.org/3/movie/popular/?api_key=$apiKey&page=$page';

    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> temp = jsonDecode(response.body)['results'];
      final result = temp.map((e) => Movie.fromJson(e)).toList();
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

MovieRepository initializeMovieRepository() {
  final httpClient = http.Client();
  const apiKey = '5cc03d5034d6041278b8e75bf5debf71';
  return MovieRepository(httpClient: httpClient, apiKey: apiKey);
}
