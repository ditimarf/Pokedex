import 'package:pokedex/models/response/pokemon_model.dart';

class PokemonListPageModel {
  int? count;
  List<PokemonModel>? results;

  PokemonListPageModel({this.count, this.results});

  PokemonListPageModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = <PokemonModel>[];
      json['results'].forEach((v) {
        results!.add(PokemonModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
