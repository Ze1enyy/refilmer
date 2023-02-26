import 'package:refilmer/data/models/details.dart';

abstract class IDetailsRepository {
  Future<MovieDetails> getDetails(int id);
  Future<List<String>> getActorNames(int id);
}
