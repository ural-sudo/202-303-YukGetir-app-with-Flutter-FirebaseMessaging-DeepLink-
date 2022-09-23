

import 'package:dio/dio.dart';
class VehicleDetail {
  List<Options>? options;
  List<Null>? hardwareOptions;

  VehicleDetail({this.options, this.hardwareOptions});

  VehicleDetail.fromJson(Map<String, dynamic> json) {
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(v);
      });
    }
    if (json['hardwareOptions'] != null) {
      hardwareOptions = <Null>[];
      json['hardwareOptions'].forEach((v) {
        hardwareOptions!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v).toList();
    }
    if (this.hardwareOptions != null) {
      data['hardwareOptions'] =
          this.hardwareOptions!.map((v) => v).toList();
    }
    return data;
  }
}