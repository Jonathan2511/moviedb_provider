import 'package:flutter/material.dart';
import 'package:moviedb_provider/views/movie/movie_page.dart';
import 'package:moviedb_provider/views/search/search_page.dart';
import 'package:moviedb_provider/views/setting/setting_page.dart';
import 'package:provider/provider.dart';
import 'package:moviedb_provider/providers/navigation_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const List<Widget> _pages = [MoviePage(), SearchPage(), SettingPage()];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final selectedIndex = navigationProvider.currentIndex;

    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          navigationProvider.setIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
