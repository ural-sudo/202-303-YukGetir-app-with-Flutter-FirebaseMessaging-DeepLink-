


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:yuk_getir/Service/models/favorites_model.dart';

abstract class IFavoriteService{
  Future<bool> addToFavorite(Favorite model);
  Future<bool>removeFromFavorite(String id);
}


class FavoriteCervise implements IFavoriteService{

  late final Dio _dio;

  FavoriteCervise(){
    _dio = Dio(BaseOptions(baseUrl:"https://api.yukgetir.com/" ));
  }

  Future<bool> addToFavorite(Favorite model) async {
    final response = await _dio.post("user/addCargoToFavorite",data: model);
    return response.statusCode == HttpStatus.created;
  }

  Future<bool>removeFromFavorite(String id) async {
    final response = await _dio.delete("user/removeCargoFromFavorites",data: id);
    return response.statusCode == HttpStatus.ok;
  }
}