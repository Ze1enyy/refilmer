import 'package:bloc/bloc.dart';
import '../data/models/movie.dart';
import '../data/repositories/movie_repository_interface.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(this.repository) : super(MovieInitial());
  final IMovieRepository repository;
  int currentPage = 1;

  Future<void> loadMovies() async {
    if (state is MovieLoading) return;

    final currentState = state;
    var oldMovies = <Movie>[];
    if (currentState is MovieLoaded) {
      oldMovies = currentState.movies;
    }
    emit(MovieLoading(oldMovies, isFirstFetch: currentPage == 1));

    try {
      await repository.getMovies(currentPage).then((newMovies) {
        currentPage++;
        final movies = (state as MovieLoading).oldMovies;
        movies.addAll(newMovies);
        emit(MovieLoaded(movies: movies));
      });
    } catch (error) {
      emit(MovieError(message: error.toString()));
    }
  }
}
