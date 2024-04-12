

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
      final CategoryModel categories = (await _myRepo.fechCategoryList());

      // Store the fetched categories in the database
      await SQLHelper.storeCategories(categories.data!.cast<DatabaseCategoryModel>());

      // Set the category list in the provider
      setCategoryList(ApiResponse.completed(categories.data!.cast<CategoryModel>()));
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

