import 'package:offline_database_crud/Api/Data/Response/api_response.dart';
import 'package:offline_database_crud/Api/Data/Response/status.dart';
import 'package:offline_database_crud/Api/Models/category_model.dart';
import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';
import 'package:offline_database_crud/Repository/home_repository.dart';

class HomeViewModel {
  final HomeRepository _myRepo = HomeRepository();
  ApiResponse<List<CategoryModel>> categoryList = ApiResponse.loading();

Future<void> fetchCategoryListFromAPI() async {
  try {
    // Fetch categories from the API
    final CategoryModel categoryResponse = await _myRepo.fechCategoryList();
    
    // Wrap the response in ApiResponse object
    final ApiResponse<CategoryModel> apiResponse = ApiResponse.completed(categoryResponse);

    if (apiResponse.status == Status.COMPLETED && apiResponse.data != null) {
      // Transform CategoryModel objects into DatabaseCategoryModel objects
      List<DatabaseCategoryModel> databaseCategories = apiResponse.data!.data!.map((category) {
        return DatabaseCategoryModel(
          id: category.id ?? 0,
          name: category.name ?? '',
          description: category.description ?? '',
          // Add other properties as needed
        );
      }).toList();

      // Store the transformed categories in the offline database
      await SQLHelper.storeCategories(databaseCategories);
    } else {
      throw Exception('Error fetching categories: ${apiResponse.message}');
    }
  } catch (error) {
    print('Error fetching categories: $error');
    throw Exception('Error fetching categories: $error');
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
