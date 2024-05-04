import 'dart:developer';
import 'package:offline_database_crud/Api/Data/Network/base_api_service.dart';
import 'package:offline_database_crud/Api/Data/Network/network_api_service.dart';
import 'package:offline_database_crud/Api/Models/category_model.dart';
import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';
import 'package:offline_database_crud/Res/app_url.dart';




class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  // Fetch Category  List /////////

Future<List<DatabaseCategoryModel>> fetchCategoryList() async {
  try {
    dynamic response = await _apiServices.getGetApiResponse(AppUrl.categoryGetDataEndPoint);

    // Extract relevant data from the response and convert it to DatabaseCategoryModel
    List<DatabaseCategoryModel> categories = (response as List).map((categoryData) {
      return DatabaseCategoryModel.fromMap(categoryData);
    }).toList();

    // Store the categories in the local database
    await SQLHelper.storeCategories(categories);

    // Log the success of the storage operation
    log('Categories stored successfully: $categories');

    // Return the list of categories
    return categories;
  } catch (e) {
    // Handle any errors
    print('Error fetching categories: $e');
    throw e; // Rethrow the error to be handled by the caller
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
