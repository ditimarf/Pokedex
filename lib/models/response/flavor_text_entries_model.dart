import 'package:pokedex/models/response/response_model.dart';

class FlavorTextEntriesModel {
  String? flavorText;
  ResponseModel? language;
  ResponseModel? version;

  FlavorTextEntriesModel({this.flavorText, this.language, this.version});

  FlavorTextEntriesModel.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavor_text'];
    language =
    json['language'] != null ? new ResponseModel.fromJson(json['language']) : null;
    version =
    json['version'] != null ? new ResponseModel.fromJson(json['version']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flavor_text'] = this.flavorText;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    if (this.version != null) {
      data['version'] = this.version!.toJson();
    }
    return data;
  }
}