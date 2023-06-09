import 'package:pokedex/models/response/response_model.dart';

class StatsModel {
  int? baseStat;
  int? effort;
  ResponseModel? stat;

  StatsModel({this.baseStat, this.effort, this.stat});

  StatsModel.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? new ResponseModel.fromJson(json['stat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_stat'] = this.baseStat;
    data['effort'] = this.effort;
    if (this.stat != null) {
      data['stat'] = this.stat!.toJson();
    }
    return data;
  }
}
