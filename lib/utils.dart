import 'package:flutter/material.dart';

class Utils {
  static Color getTypeColor(String? type) {
    switch (type) {
      case "bug":
        return const Color(0xFFA7B723);
      case "dark":
        return const Color(0xFF75574C);
      case "dragon":
        return const Color(0xFF7037FF);
      case "electric":
        return const Color(0xFFF9CF30);
      case "fairy":
        return const Color(0xFFE69EAC);
      case "fighting":
        return const Color(0xFFC12239);
      case "fire":
        return const Color(0xFFF57D31);
      case "flying":
        return const Color(0xFFA891EC);
      case "ghost":
        return const Color(0xFF70559B);
      case "normal":
        return const Color(0xFFAAA67F);
      case "grass":
        return const Color(0xFF74CB48);
      case "ground":
        return const Color(0xFFDEC16B);
      case "ice":
        return const Color(0xFF9AD6DF);
      case "poison":
        return const Color(0xFFA43E9E);
      case "psychic":
        return const Color(0xFFFB5584);
      case "rock":
        return const Color(0xFFB69E31);
      case "steel":
        return const Color(0xFFB7B9D0);
      case "water":
        return const Color(0xFF6493EB);

      default:
        return Colors.grey;
    }
  }

  static String getStatAbbreviation(String stat) {
    switch (stat) {
      case 'attack':
        return 'atk';
      case 'defense':
        return 'def';
      case 'special-attack':
        return 'satk';
      case 'special-defense':
        return 'sdef';
      case 'speed':
        return 'spd';

      default:
        return stat;
    }
  }

  static String firstWordUpperCase(String? text) {
    if (text != null) {
      return text[0].toUpperCase() + text.substring(1).toLowerCase();
    } else {
      return '';
    }
  }

  static String urlOfficialArtwork(String id){
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
}
