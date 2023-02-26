import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../data/models/details.dart';

@immutable
abstract class DetailsState extends Equatable {}

class DetailsInitial extends DetailsState {
  @override
  List<Object?> get props => [];
}

class DetailsLoading extends DetailsState {
  @override
  List<Object?> get props => [];
}

class DetailsLoaded extends DetailsState {
  final MovieDetails movieDetails;
  final List<String> actors;

  DetailsLoaded({required this.movieDetails, required this.actors});

  @override
  List<Object?> get props => [movieDetails];
}

class DetailsError extends DetailsState {
  final String message;
  DetailsError({required this.message});
  @override
  List<Object?> get props => [message];
}
