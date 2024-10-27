import 'package:astro_office/config/theme/app_theme.dart';
import 'package:astro_office/screens/home_page.dart';
import 'package:astro_office/screens/filters.dart';
import 'package:astro_office/screens/search.dart';
import 'package:astro_office/screens/searched_card.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme(),
      initialRoute: '/home', // Ruta inicial
      routes: {
        '/': (context) => const MyHomePage(), // Pantalla de inicio
        '/home': (context) => const FiltersPage(), // Pantalla de resultados
        '/search': (context) => const OfficeSearchPage(), // Pantalla de búsqueda
        '/searched_card': (context) => const SearchedCardPage(), // Pantalla de resultados
      },
    );
  }
}