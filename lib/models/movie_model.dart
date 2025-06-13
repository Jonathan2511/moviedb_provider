class Movie {
  final int id;
  final String title;
  final String posterPath;
  final num rating;
  final List<String> genres;
  final String overview;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.rating,
    required this.genres,
    required this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath:
          json['poster_path'] != null
              ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
              : '',
      rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      genres: [],
      overview: json['overview'],
    );
  }
}
