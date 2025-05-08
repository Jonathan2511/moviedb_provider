import 'package:flutter/material.dart';
import 'package:moviedb_provider/views/movie/component/movie_card.dart';
import 'package:moviedb_provider/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final movies = moviesProvider.movies;
    final isLoading = moviesProvider.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies (${movies.length})'),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              moviesProvider.fetchMovies(value);
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(value: 20, child: Text('Show 20 movies')),
                PopupMenuItem(value: 60, child: Text('Show 60 movies')),
                PopupMenuItem(value: 100, child: Text('Show 100 movies')),
                PopupMenuItem(value: 200, child: Text('Show 200 movies')),
                PopupMenuItem(value: 500, child: Text('Show 500 movies')),
                PopupMenuItem(value: 1000, child: Text('Show 1000 movies')),
                PopupMenuItem(value: 2500, child: Text('Show 2500 movies')),
                PopupMenuItem(value: 5000, child: Text('Show 5000 movies')),
                PopupMenuItem(value: 10000, child: Text('Show 10000 movies')),
              ];
            },
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: () async {
                  await moviesProvider.fetchMovies(movies.length);
                },
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(movie: movies[index]);
                  },
                ),
                // child: SingleChildScrollView(
                //   child: Column(
                //     children:
                //         movies.map((movie) => MovieCard(movie: movie)).toList(),
                //   ),
                // ),
              ),
    );
  }
}
