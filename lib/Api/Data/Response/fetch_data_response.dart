

import 'dart:developer';

import 'package:offline_database_crud/Api/Data/Response/api_response.dart';

import 'package:offline_database_crud/Api/Models/category_model.dart';
import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';
import 'package:offline_database_crud/Repository/home_repository.dart';

class HomeViewModel {
  final HomeRepository _myRepo = HomeRepository();
  ApiResponse<List<CategoryModel>> categoryList = ApiResponse.loading();

Future<void> fetchCategoryListFromAPI() async {
  setCategoryList(ApiResponse.loading());
  try {
      
    // Fetch categories from the API
    final CategoryModel categoryResponse = (await _myRepo.fetchCategoryList()) as CategoryModel;
     await SQLHelper.storeCategories(categoryResponse.data! as List<DatabaseCategoryModel>);
     log('Data Arrive or Not >>> ${categoryResponse.data!}');
      log('Data Arrive or op >>> ${categoryResponse.data! as List<DatabaseCategoryModel>}');
      log('Store >>> ${SQLHelper.storeCategories(categoryResponse.data! as List<DatabaseCategoryModel>)}');
      // Set the category list in the provider
       setCategoryList(ApiResponse.completed(categoryResponse.data!.cast<CategoryModel>()));
    log('Data Arrive or yes >>> ${categoryResponse.data!.cast<CategoryModel>()}');
  } catch (error) {
      setCategoryList(ApiResponse.error(error.toString()));
    }
}



  Future<void> postCategoryListFromAPI(String name, String description) async {
    setCategoryList(ApiResponse.loading());

    try {
      final CategoryModel categories = await _myRepo.postCategoryList(name,description);

      // Store the fetched categories in the database
      await SQLHelper.createCategory(categories.data! as DatabaseCategoryModel);

      // Set the category list in the provider
       setCategoryList(ApiResponse.completed(categories.data!.cast<CategoryModel>()));
    } catch (error) {
      setCategoryList(ApiResponse.error(error.toString()));
    }
  }





  void setCategoryList(ApiResponse<List<CategoryModel>> response) {
    categoryList = response;
  }
}
