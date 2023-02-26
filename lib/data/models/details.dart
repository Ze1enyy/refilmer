class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final String img;
  final int time;
  final String dateTime;
  final List<dynamic> countryCode;
  final List<dynamic> genres;
  final List<dynamic> studios;

  MovieDetails(
      {required this.id,
      required this.title,
      required this.overview,
      required this.time,
      required this.img,
      required this.dateTime,
      required this.countryCode,
      required this.genres,
      required this.studios});
  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    List<dynamic> genresJson = json['genres'];
    List genres = [];
    if (genresJson.isNotEmpty) {
      genres = genresJson.map((genre) => genre['name']).toList();
    }
    List<dynamic> countriesJson = json['production_countries'];
    List countries = [];
    if (countriesJson.isNotEmpty) {
      countries = countriesJson.map((country) => country['name']).toList();
    }
    List<dynamic> studiosJson = json['production_companies'];
    List studios = [];
    if (studiosJson.isNotEmpty) {
      studios = studiosJson.map((studio) => studio['name']).toList();
    }
    return MovieDetails(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        time: json['runtime'],
        img: json['poster_path'],
        dateTime: json['release_date'],
        countryCode: countries,
        genres: genres,
        studios: studios);
  }
}
