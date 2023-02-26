import 'package:flutter/material.dart';
import 'package:refilmer/presentation/views/movie/movie_screen.dart';
import 'data/repositories/movie_repository.dart';
import 'data/repositories/movie_repository_interface.dart';

void main() {
  final IMovieRepository repository = initializeMovieRepository();
  runApp(MaterialApp(
    home: MovieScreen(
      movieRepository: repository,
    ),
  ));
}
