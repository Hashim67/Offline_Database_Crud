//  import 'package:offline_database_crud/Api/Data/Response/api_response.dart';
//  import 'package:offline_database_crud/Api/Models/category_model.dart';
// import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
// import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';


//   import 'package:offline_database_crud/Repository/home_repository.dart';

// class HomeViewModel {
//   final HomeRepository _myRepo = HomeRepository();
//   ApiResponse<CategoryModel> categoryList = ApiResponse.loading();

//   Future<void> fetchCategoryListFromAPI() async {
//     setCategoryList(ApiResponse.loading());

//     try {
//       final CategoryModel categories = await _myRepo.fechCategoryList(); // Fetch the list of categories directly
//       print('Data >> ${categories}');
//       // Store the categories in the database
//       await SQLHelper.storeCategories(categories.map((category) => DatabaseCategoryModel(
//         id: category.id ?? 0,
//         name: category.name ?? '',
//         description: category.description ?? '',
//       )).toList());

//       // Set the category list in the provider
//       setCategoryList(ApiResponse.completed(categories));
//     } catch (error) {
//       setCategoryList(ApiResponse.error(error.toString()));
//     }
//   }

// void setCategoryList(ApiResponse<dynamic> response) {
//   categoryList = response as ApiResponse<CategoryModel>;
// }


// }


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
      final CategoryModel categories = await _myRepo.fechCategoryList();

      // Store the fetched categories in the database
      await SQLHelper.storeCategories(categories.data!.cast<DatabaseCategoryModel>());

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

