import 'package:pokedex/integration/base_integration.dart';
import 'package:pokedex/models/response/pokemon_details_model.dart';
import 'package:pokedex/models/response/pokemon_list_page_model.dart';
import 'package:pokedex/models/response/pokemon_species_model.dart';

class PokemonIntegration extends BaseIntegration {
  static const String _pokemonApiUrl = 'https://pokeapi.co';

  static Future<PokemonListPageModel?> getPokemonList(
      int offset, int limite) async {
    var pokemonListRepsonse = await BaseIntegration.httpRequestObject(
        '$_pokemonApiUrl/api/v2/pokemon/?offset=$offset&limit=$limite');
    if (pokemonListRepsonse != null) {
      return PokemonListPageModel.fromJson(pokemonListRepsonse);
    }

    return null;
  }

  static Future<PokemonDetailsModel?> getPokemonDetails(String id) async {
    var pokemonListRepsonse = await BaseIntegration.httpRequestObject(
        '$_pokemonApiUrl/api/v2/pokemon/$id');
    if (pokemonListRepsonse != null) {
      return PokemonDetailsModel.fromJson(pokemonListRepsonse);
    }
  }

  static Future<PokemonSpeciesModel?> getPokemonSpecies(String id) async {
    var pokemonListRepsonse = await BaseIntegration.httpRequestObject(
        '$_pokemonApiUrl/api/v2/pokemon-species/$id');
    if (pokemonListRepsonse != null) {
      return PokemonSpeciesModel.fromJson(pokemonListRepsonse);
    }

    return null;
  }
}
