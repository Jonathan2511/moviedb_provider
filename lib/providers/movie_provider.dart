import 'package:flutter/material.dart';
import 'package:moviedb_provider/repositories/movie_repository.dart';
import '../models/movie_model.dart';

class MoviesProvider extends ChangeNotifier {
  final MovieService _movieService;
  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _error;
  int _maxMovies = 20;

  MoviesProvider(this._movieService) {
    // Default fetch 20 movies when provider is created
    fetchMovies(1000);
  }

  // Getters
  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get maxMovies => _maxMovies;

  // Refactored fetch movies method
  Future<void> fetchMovies(int count) async {
    _isLoading = true;
    _error = null;
    _movies = [];
    _maxMovies = count;
    notifyListeners();

    try {
      if (_maxMovies <= 2500) {
        await _fetchLimitedMovies();
      } else {
        await _fetchAndDuplicateMovies();
      }
    } catch (e) {
      _error = 'Error fetching movies: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Helper method to fetch up to 2500 movies
  Future<void> _fetchLimitedMovies() async {
    int maxPage = (_maxMovies / 20).ceil();
    List<Movie> allMovies = [];

    for (int page = 1; page <= maxPage; page++) {
      final movies = await _movieService.fetchMovies(page: page);
      allMovies.addAll(movies);
    }

    _movies = allMovies.take(_maxMovies).toList();
  }

  // Helper method to handle the duplication logic for > 2500 movies
  Future<void> _fetchAndDuplicateMovies() async {
    // First, fetch 2500 movies
    int maxPage = (2500 / 20).ceil();
    List<Movie> allMovies = [];

    for (int page = 1; page <= maxPage; page++) {
      final movies = await _movieService.fetchMovies(page: page);
      allMovies.addAll(movies);
    }

    // Duplicate the data to meet the required count
    int repeatCount = (_maxMovies / 2500).ceil();
    List<Movie> duplicatedMovies = [];

    for (int i = 0; i < repeatCount; i++) {
      duplicatedMovies.addAll(allMovies);
    }

    // Trim the duplicated list to match the required movie count
    _movies = duplicatedMovies.take(_maxMovies).toList();
  }
}
