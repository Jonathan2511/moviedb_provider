import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class MovieService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.themoviedb.org/3/movie/popular';
  final String _apiKey = '118910ebd93a2ef0d7e36f033747b6c8';

  Future<List<Movie>> fetchMovies({int page = 1}) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {'api_key': _apiKey, 'page': page},
    );
    if (response.statusCode == 200) {
      final results = response.data['results'] as List;
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
