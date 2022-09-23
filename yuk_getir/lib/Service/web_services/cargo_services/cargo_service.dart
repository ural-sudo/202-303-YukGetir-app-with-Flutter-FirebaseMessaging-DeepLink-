
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:yuk_getir/Service/models/cargo_model.dart';


abstract class ICargoService{
  Future<List<CargoModel>?> fetchCargo();
  Future<bool> addCargo (CargoModel model);
}

class CargoService implements ICargoService{
  
  late final Dio _dio;
  
  CargoService(){
    _dio = Dio(BaseOptions(baseUrl:"https://api.yukgetir.com/"));   
  }

  Future<List<CargoModel>?> fetchCargo() async {
    final response = await _dio.get("listing/cargo/getLastAdverts");
    if(response.statusCode == HttpStatus.ok){
      final datas =  response.data;
      if(datas is List){
        return datas.map((e) => CargoModel.fromJson(e)).toList();
      }
    }else{
      return null;
    }
  }
  Future<bool> addCargo (CargoModel model) async {
    final response = await _dio.post('listing/cargo/create',data: model);
    
    return response.statusCode == HttpStatus.created;
  }

}