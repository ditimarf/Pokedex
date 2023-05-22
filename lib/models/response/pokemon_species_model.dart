import 'flavor_text_entries_model.dart';

class PokemonSpeciesModel {
  List<FlavorTextEntriesModel>? flavorTextEntries;

  PokemonSpeciesModel({this.flavorTextEntries});

  PokemonSpeciesModel.fromJson(Map<String, dynamic> json) {
    if (json['flavor_text_entries'] != null) {
      flavorTextEntries = <FlavorTextEntriesModel>[];
      json['flavor_text_entries'].forEach((v) {
        flavorTextEntries!.add(new FlavorTextEntriesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.flavorTextEntries != null) {
      data['flavor_text_entries'] =
          this.flavorTextEntries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
