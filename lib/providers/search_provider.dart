import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moviedb_provider/models/movie_model.dart';
import 'package:moviedb_provider/providers/movie_provider.dart';

class SearchProvider extends ChangeNotifier {
  final BuildContext _context;
  String _searchQuery = '';
  List<Movie> _searchResults = [];
  String? _error;

  SearchProvider(this._context);

  // Getters
  String get searchQuery => _searchQuery;
  List<Movie> get searchResults => _searchResults;
  String? get error => _error;

  // Update search query and perform search
  void updateSearchQuery(String query) {
    _searchQuery = query;
    searchMovies(query);
  }

  // Search movies based on query
  Future<void> searchMovies(String query) async {
    // If query is empty, return empty list
    if (query.isEmpty) {
      _searchResults = [];
      _error = null;
      notifyListeners();
      return;
    }

    try {
      // Get all movies from MoviesProvider
      final allMovies =
          Provider.of<MoviesProvider>(_context, listen: false).movies;

      // Search based on query
      final results =
          allMovies
              .where(
                (movie) =>
                    movie.title.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

      _searchResults = results;
      _error = null;
    } catch (e) {
      // Handle error
      _searchResults = [];
      _error = e.toString();

      // Show error message
      ScaffoldMessenger.of(
        _context,
      ).showSnackBar(SnackBar(content: Text(_error!)));
    }

    notifyListeners();
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    _error = null;
    notifyListeners();
  }
}
