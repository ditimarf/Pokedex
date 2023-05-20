import 'package:pokedex/integration/pokemon_integration.dart';
import 'package:pokedex/models/response/pokemon_list_page_model.dart';

class PokemonService {
  static Future<PokemonListPageModel?> getPokemonList(
      int pageKey, int pageSize) async {
    int offSet = pageKey * pageSize;
    return await PokemonIntegration.getPokemonList(offSet, pageSize);
  }
}
