import 'package:pokedex/models/response/response_model.dart';

class TypesModel {
  int? slot;
  ResponseModel? type;

  TypesModel({this.slot, this.type});

  TypesModel.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? new ResponseModel.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}