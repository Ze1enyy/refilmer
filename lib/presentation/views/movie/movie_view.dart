import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:refilmer/controllers/movie_cubit.dart';

import '../../../data/models/movie.dart';
import '../../../utils/constants.dart';
import '../details/details_screen.dart';

class MovieView extends StatefulWidget {
  final List<Movie> movies;
  final bool isLoading;

  const MovieView({super.key, required this.movies, required this.isLoading});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setupScrollController();
  }

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<MovieCubit>(context).loadMovies();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Refilmer",
            style: GoogleFonts.fredokaOne(textStyle: primaryText)),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          controller: scrollController,
          itemCount: widget.movies.length + (widget.isLoading ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: !kIsWeb ? 1 / 1.8 : 1 / 1.6,
            crossAxisCount: !kIsWeb ? 2 : 4,
            crossAxisSpacing: !kIsWeb ? 15 : 30,
            mainAxisSpacing: !kIsWeb ? 10 : 30,
          ),
          itemBuilder: ((context, index) {
            if (index < widget.movies.length) {
              return _buildMovieItem(widget.movies[index]);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }

  Widget _buildMovieItem(Movie movie) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 3),
        )
      ]),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(id: movie.id))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.network(
                'http://image.tmdb.org/t/p/w500${movie.img}',
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.white,
                            ),
                          ),
              ),
            ),
            Text(movie.title,
                style: TextStyle(
                    fontSize: !kIsWeb && movie.title.length > 30 ? 12 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
