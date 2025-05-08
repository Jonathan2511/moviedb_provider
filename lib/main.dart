import 'package:flutter/material.dart';
import 'package:moviedb_provider/repositories/movie_repository.dart';
import 'package:provider/provider.dart';
import 'package:moviedb_provider/views/main_screen.dart';
import 'package:moviedb_provider/providers/theme_provider.dart';
import 'package:moviedb_provider/providers/navigation_provider.dart';
import 'package:moviedb_provider/providers/movie_provider.dart';
import 'package:moviedb_provider/providers/search_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Movie providers
        Provider<MovieService>(create: (_) => MovieService()),
        ChangeNotifierProxyProvider<MovieService, MoviesProvider>(
          create:
              (context) => MoviesProvider(
                Provider.of<MovieService>(context, listen: false),
              ),
          update:
              (context, service, previous) =>
                  previous ?? MoviesProvider(service),
        ),

        // Theme provider
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // Navigation provider
        ChangeNotifierProvider(create: (_) => NavigationProvider()),

        // Search provNider
        ChangeNotifierProxyProvider<MoviesProvider, SearchProvider>(
          create: (context) => SearchProvider(context),
          update: (context, _, previous) => previous ?? SearchProvider(context),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Movie Catalog',
          theme:
              themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          // theme: ThemeData.light(),
          // darkTheme: ThemeData.dark(),
          // themeMode: ThemeMode.system,
          home: const MainScreen(),
        );
      },
    );
  }
}
