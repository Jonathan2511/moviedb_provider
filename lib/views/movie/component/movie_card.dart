import 'package:flutter/material.dart';
import 'package:moviedb_provider/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        children: [
          Container(
            height: 135,
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(movie.posterPath),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rating: ${movie.rating}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Overview: ${movie.overview}',
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // child: ListTile(
      //   leading: Image.network(movie.posterPath, fit: BoxFit.cover),
      //   title: Text(movie.title),
      //   subtitle: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text('Rating: ${movie.rating}'),
      //       Text('Overview: ${movie.overview}',
      //           maxLines: 3, overflow: TextOverflow.ellipsis),
      //     ],
      //   ),
      // ),
    );
  }
}
