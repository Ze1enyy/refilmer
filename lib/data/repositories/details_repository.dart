import 'dart:convert';
import 'package:refilmer/data/models/details.dart';
import 'package:http/http.dart' as http;
import 'package:refilmer/data/repositories/details_repository_interface.dart';

class DetailsRepository implements IDetailsRepository {
  final http.Client httpClient;
  final String apiKey;

  DetailsRepository({required this.httpClient, required this.apiKey});

  @override
  Future<MovieDetails> getDetails(int id) async {
    String url = 'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return MovieDetails.fromJson(jsonResponse);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  @override
  Future<List<String>> getActorNames(int id) async {
    String url =
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=$apiKey';

    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['cast'];
      final result = data.map((e) => e['name'] as String).toList();
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

DetailsRepository initializeDetailsRepository() {
  final httpClient = http.Client();
  const apiKey = '5cc03d5034d6041278b8e75bf5debf71';
  return DetailsRepository(httpClient: httpClient, apiKey: apiKey);
}
