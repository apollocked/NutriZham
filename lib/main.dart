import 'package:flutter/material.dart';
import 'package:nutrizham/pages/home_page.dart';

void main() {
  runApp(const NutriZhamApp());
}

class NutriZhamApp extends StatelessWidget {
  const NutriZhamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriZham',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      home: const RecipeListScreen(),
    );
  }
}
