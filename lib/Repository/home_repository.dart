import 'dart:developer';
import 'package:offline_database_crud/Api/Data/Network/base_api_service.dart';
import 'package:offline_database_crud/Api/Data/Network/network_api_service.dart';
import 'package:offline_database_crud/Api/Models/category_model.dart';
import 'package:offline_database_crud/Res/app_url.dart';




class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  // Fetch Category  List /////////

 Future<dynamic> fechCategoryList() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        AppUrl.categoryGetDataEndPoint,
      );
      log('response getGetApiResponse movies >>> ${response}');
      return response = CategoryModel.fromMap(response);
    } catch (e) {
      
      throw e;
    }
  } 


  //// Post/Add Category  List /////////



 Future<CategoryModel> postCategoryList(String name, String description) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.categoryADDDataEndPoint,
        name,
        description
      );
      //  log('Post Api Data >>> ${response}');
      return response;
    } catch (e) {
      
      throw e;
    }
  }
}
