import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refilmer/presentation/views/movie/movie_view.dart';
import '../../../data/models/movie.dart';
import '../../../data/repositories/movie_repository_interface.dart';
import '../../../controllers/movie_cubit.dart';
import '../../../controllers/movie_state.dart';

class MovieScreen extends StatefulWidget {
  final IMovieRepository movieRepository;

  const MovieScreen({Key? key, required this.movieRepository})
      : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late final MovieCubit _movieCubit;

  @override
  void initState() {
    super.initState();
    _movieCubit = MovieCubit(widget.movieRepository)..loadMovies();
  }

  @override
  void dispose() {
    _movieCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieCubit>(
      create: (context) => _movieCubit,
      child: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading && state.isFirstFetch) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              ),
            );
          } else if (state is MovieLoading || state is MovieLoaded) {
            return _buildMovieView(state);
          } else if (state is MovieError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildMovieView(MovieState state) {
    final List<Movie> movies;
    final bool isLoading;

    if (state is MovieLoading) {
      movies = state.oldMovies;
      isLoading = true;
    } else if (state is MovieLoaded) {
      movies = state.movies;
      isLoading = false;
    } else {
      movies = [];
      isLoading = false;
    }

    return MovieView(
      movies: movies,
      isLoading: isLoading,
    );
  }
}
