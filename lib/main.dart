import 'package:flutter/material.dart';
import 'package:pokedex/configs.dart';
import 'package:pokedex/views/pokemon_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pokédex',
        theme: ThemeData(
          primaryColor: Configs.primaryDefault,
          appBarTheme: AppBarTheme(color: Configs.primaryDefault, elevation: 0),
        ),
        home: PokedexHomePage(title: 'Pokédex'));
  }
}
