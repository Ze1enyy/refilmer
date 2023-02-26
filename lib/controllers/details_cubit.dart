import 'package:bloc/bloc.dart';
import '../data/repositories/details_repository_interface.dart';
import 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.repository) : super(DetailsInitial());
  final IDetailsRepository repository;

  Future<void> loadDetails(int id) async {
    if (state is DetailsLoading) return;

    try {
      emit(DetailsLoading());

      final movieDetails = await repository.getDetails(id);
      final actors = await repository.getActorNames(id);

      emit(DetailsLoaded(movieDetails: movieDetails, actors: actors));
    } catch (error) {
      emit(DetailsError(message: error.toString()));
    }
  }
}
