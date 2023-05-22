import 'package:pokedex/integration/pokemon_integration.dart';
import 'package:pokedex/models/response/pokemon_details_model.dart';
import 'package:pokedex/models/response/pokemon_list_page_model.dart';
import 'package:pokedex/models/response/pokemon_species_model.dart';

class PokemonService {
  static Future<PokemonListPageModel?> getPokemonList(
      int pageKey, int pageSize) async {
    int offSet = pageKey * pageSize;
    return await PokemonIntegration.getPokemonList(offSet, pageSize);
  }

  static Future<PokemonDetailsModel?> getPokemonDetails(String id) async {
    return await PokemonIntegration.getPokemonDetails(id);
  }

  static Future<PokemonSpeciesModel?> getPokemonSpecies(String id) async {
    return await PokemonIntegration.getPokemonSpecies(id);
  }
}
