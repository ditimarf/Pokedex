class PokemonModel {
  String? id;
  String? name;
  String? url;

  PokemonModel({this.name, this.url});

  PokemonModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = url?.split('/').reversed.elementAt(1);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
