import 'abilities_model.dart';
import 'stats_model.dart';
import 'types_model.dart';

class PokemonDetailsModel {
  List<AbilitiesModel>? abilities;
  List<StatsModel>? stats;
  List<TypesModel>? types;
  int? id;
  String? name;
  String? official_artwork;
  int? height;
  int? weight;

  String? idText() {
    if (id != null)
      return '#${id.toString().padLeft(4, '0')}';
    else
      return null;
  }

  PokemonDetailsModel(
      {this.abilities,
      this.height,
      this.id,
      this.name,
      this.stats,
      this.types,
      this.weight,
      this.official_artwork});

  PokemonDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    height = json['height'];
    weight = json['weight'];

    if (json['abilities'] != null) {
      abilities = <AbilitiesModel>[];
      json['abilities'].forEach((v) {
        abilities!.add(new AbilitiesModel.fromJson(v));
      });
    }

    if (json['stats'] != null) {
      stats = <StatsModel>[];
      json['stats'].forEach((v) {
        stats!.add(new StatsModel.fromJson(v));
      });
    }

    if (json['types'] != null) {
      types = <TypesModel>[];
      json['types'].forEach((v) {
        types!.add(new TypesModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.abilities != null) {
      data['abilities'] = this.abilities!.map((v) => v.toJson()).toList();
    }
    data['height'] = this.height;
    data['id'] = this.id;
    data['name'] = this.name;

    if (this.stats != null)
      data['stats'] = this.stats!.map((v) => v.toJson()).toList();

    if (this.types != null)
      data['types'] = this.types!.map((v) => v.toJson()).toList();

    data['weight'] = this.weight;
    return data;
  }
}
