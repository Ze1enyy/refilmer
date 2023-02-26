class Movie {
  final int id;
  final String title;
  final String img;
  final String overview;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.img,
  });
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        img: json['poster_path']);
  }
}
