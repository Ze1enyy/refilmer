import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:refilmer/data/models/details.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';

class DetailsView extends StatelessWidget {
  final MovieDetails movieDetails;
  final List<String> actors;
  const DetailsView(
      {super.key, required this.movieDetails, required this.actors});

  @override
  Widget build(BuildContext context) {
    DateTime movieDate = DateTime.parse(movieDetails.dateTime);
    String formattedDate = DateFormat("dd-MM-yyyy").format(movieDate);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Refilmer",
            style: GoogleFonts.fredokaOne(textStyle: primaryText)),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Image.network(
                  'http://image.tmdb.org/t/p/w500${movieDetails.img}',
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
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                movieDetails.title,
                style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Runtime: ${movieDetails.time} minutes (${movieDetails.time ~/ 60} hours and ${movieDetails.time % 60} minutes)",
              style: secondaryText,
              textAlign: TextAlign.center,
            ),
            Text(
              "Release date: $formattedDate",
              style: secondaryText,
            ),
            Text(
                movieDetails.countryCode.isNotEmpty
                    ? "Country: ${movieDetails.countryCode.join(", ")}"
                    : "Unknown",
                style: secondaryText,
                textAlign: TextAlign.center),
            Text(
                movieDetails.genres.isNotEmpty
                    ? "Genre: ${movieDetails.genres.join(", ")}"
                    : "Unknown",
                style: secondaryText,
                textAlign: TextAlign.center),
            Text(
              movieDetails.studios.isNotEmpty
                  ? "Production company: ${movieDetails.studios.join(", ")}"
                  : "Unknown",
              style: secondaryText,
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.amber,
              title: Text(
                "Description",
                style: primaryText,
              ),
              children: [
                Container(
                  color: Colors.black38,
                  child: Text(
                    movieDetails.overview,
                    style: secondaryText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.amber,
              title: Text(
                "Cast",
                style: primaryText,
              ),
              children: [
                Container(
                  color: Colors.black38,
                  child: Text(
                    actors.join(", "),
                    style: secondaryText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
