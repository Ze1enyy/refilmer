import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../data/models/movie.dart';

@immutable
abstract class MovieState extends Equatable {}

class MovieInitial extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoading extends MovieState {
  final List<Movie> oldMovies;
  final bool isFirstFetch;
  MovieLoading(this.oldMovies, {this.isFirstFetch = false});
  @override
  List<Object?> get props => [oldMovies, isFirstFetch];
}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  MovieLoaded({required this.movies});

  @override
  List<Object?> get props => [movies];
}

class MovieError extends MovieState {
  final String message;
  MovieError({required this.message});
  @override
  List<Object?> get props => [message];
}
