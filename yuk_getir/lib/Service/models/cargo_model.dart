import 'package:yuk_getir/Service/models/publish_model.dart';
import 'package:yuk_getir/Service/models/vehicle_detail_model.dart';

import 'owner_model.dart';

class CargoModel {
  String? id;
  String? status;
  Publish? publish;
  String? distance;
  String? loadStartDate;
  String? loadEndDate;
  String? loadFrom;
  String? loadFromTown;
  String? unLoadDate;
  String? unLoadTo;
  String? unLoadToTown;
  num? weight;
  String? weightUnit;
  num? number;
  Owner? owner;

  CargoModel(
      {this.id,
      this.status,
      this.publish,
      this.distance,
      this.loadStartDate,
      this.loadEndDate,
      this.loadFrom,
      this.loadFromTown,
      this.unLoadDate,
      this.unLoadTo,
      this.unLoadToTown,
      this.weight,
      this.weightUnit,
      this.number,
      this.owner});

  CargoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    publish =
        json['publish'] != null ?  Publish.fromJson(json['publish']) : null;
    distance = json['distance'];
    loadStartDate = json['loadStartDate'];
    loadEndDate = json['loadEndDate'];
    loadFrom = json['loadFrom'];
    loadFromTown = json['loadFromTown'];
    unLoadDate = json['unLoadDate'];
    unLoadTo = json['unLoadTo'];
    unLoadToTown = json['unLoadToTown'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    number = json['number'];
    owner = json['owner'] != null ?  Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.publish != null) {
      data['publish'] = this.publish!.toJson();
    }
    data['distance'] = this.distance;
    data['loadStartDate'] = this.loadStartDate;
    data['loadEndDate'] = this.loadEndDate;
    data['loadFrom'] = this.loadFrom;
    data['loadFromTown'] = this.loadFromTown;
    data['unLoadDate'] = this.unLoadDate;
    data['unLoadTo'] = this.unLoadTo;
    data['unLoadToTown'] = this.unLoadToTown;
    data['weight'] = this.weight;
    data['weightUnit'] = this.weightUnit;
    data['number'] = this.number;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    return data;
  }
}