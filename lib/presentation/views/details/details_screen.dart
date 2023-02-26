import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refilmer/presentation/views/details/details_view.dart';
import '../../../controllers/details_cubit.dart';
import '../../../controllers/details_state.dart';
import '../../../data/models/details.dart';
import '../../../data/repositories/details_repository.dart';

class DetailsScreen extends StatefulWidget {
  final int id;

  const DetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final DetailsCubit _detailsCubit;
  late final DetailsRepository repository;

  @override
  void initState() {
    super.initState();
    repository = initializeDetailsRepository();
    _detailsCubit = DetailsCubit(repository)..loadDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsCubit>.value(
      value: _detailsCubit,
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.white,
              ),
            );
          } else if (state is DetailsLoaded) {
            MovieDetails movieDetails = state.movieDetails;
            List<String> actors = state.actors;
            return DetailsView(movieDetails: movieDetails, actors: actors);
          } else if (state is DetailsError) {
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
}
