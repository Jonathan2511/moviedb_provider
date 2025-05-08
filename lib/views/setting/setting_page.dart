import 'package:flutter/material.dart';
import 'package:moviedb_provider/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkTheme = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Dark Mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Switch(
              value: isDarkTheme,
              onChanged: (value) {
                themeProvider.setDarkMode(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
