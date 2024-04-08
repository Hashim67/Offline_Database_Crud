import 'dart:developer';

import 'package:offline_database_crud/Api/Data/Network/base_api_service.dart';
import 'package:offline_database_crud/Api/Data/Network/network_api_service.dart';
import 'package:offline_database_crud/Api/Models/category_model.dart';
import 'package:offline_database_crud/Res/app_url.dart';




class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  //// Fetch Movie List /////////

  Future<CategoryModel> fechCategoryList() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        AppUrl.categoryGetDataEndPoint,
      );
      log('response getGetApiResponse movies >>> ${response}');
      return response = CategoryModel.fromMap(response);
    } catch (e) {
      log('catch e >>> $e');
      throw e;
    }
  }


}
