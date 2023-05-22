import 'ability_model.dart';

class AbilitiesModel {
  Ability? ability;
  bool? isHidden;
  int? slot;

  AbilitiesModel({this.ability, this.isHidden, this.slot});

  AbilitiesModel.fromJson(Map<String, dynamic> json) {
    ability =
    json['ability'] != null ? new Ability.fromJson(json['ability']) : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ability != null) {
      data['ability'] = this.ability!.toJson();
    }
    data['is_hidden'] = this.isHidden;
    data['slot'] = this.slot;
    return data;
  }
}
