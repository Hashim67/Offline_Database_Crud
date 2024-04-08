// import 'package:flutter/material.dart';
// import 'package:offline_database_crud/Api/Models/category_model.dart';
// import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';

// import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';
// import 'package:offline_database_crud/Repository/home_repository.dart';

// class CategoryProvider extends ChangeNotifier {
//   final HomeRepository _myRepo = HomeRepository();
//   List<DatabaseCategoryModel> _categories = [];
//   List<DatabaseCategoryModel> get categories => _categories;

//   // Method to fetch category list from API, store in local database, and notify listeners
//   Future<void> fetchCategoryListFromAPI() async {
//     try {
//       // Fetch categories from the API
//       final CategoryModel categories = await _myRepo.fechCategoryList();

//       // Print API response for verification
//       print('API Response:');
//       categories.data!.forEach((categoryDatum) {
//         print('ID: ${categoryDatum.id}, Name: ${categoryDatum.name}, Description: ${categoryDatum.description}');
//       });

//       // Map API response to DatabaseCategoryModel
//       _categories = categories.data?.map((category) => DatabaseCategoryModel(
//         // id: UniqueKey().hashCode, // Generate a unique ID
//         id: category.id ?? 0,
//         name: category.name ?? '',
//         description: category.description ?? '',
//       )).toList() ?? [];

//       // Clearing the database before inserting new records
//       await SQLHelper.clearCategories();

//       // Store new records in the database
//       await SQLHelper.storeCategories(_categories);

//       // Notify listeners after updating categories
//       notifyListeners();
//     } catch (error) {
//       print('Error fetching categories from API: $error');
//       throw Exception('Error fetching categories from API: $error');
//     }
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
// import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';

// class CategoryProvider extends ChangeNotifier {
//   List<DatabaseCategoryModel> _categories = [];

//   List<DatabaseCategoryModel> get categories => _categories;

//   Future<void> fetchCategoryListFromAPI() async {
//     try {
//       _categories = await SQLHelper.getCategories();
//       notifyListeners(); // Notify listeners after updating categories
//     } catch (error) {
//       print('Error fetching categories from database: $error');
//       throw Exception('Error fetching categories from database: $error');
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';

class CategoryProvider extends ChangeNotifier {
  // ...
  List<DatabaseCategoryModel> _categories = [];
  List<DatabaseCategoryModel> get categories => _categories;
    bool _isLoading = true;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> fetchCategoryList() async {
    try {
      // Check internet connectivity
      bool isConnected = await _checkInternetConnectivity();

      if (isConnected) {
        // Fetch data from API
        final categories = await _fetchDataFromAPI();

        // Store data in offline database
        await SQLHelper.storeCategories(categories);

        // Update categories list
        _categories = categories;
      } else {
        // Fetch data from offline database
        _categories = await SQLHelper.getCategories();
      }

      // Notify listeners
      notifyListeners();
    } catch (error) {
      print('Error fetching categories: $error');
      throw Exception('Error fetching categories: $error');
    }
  }

  // Method to check internet connectivity
  Future<bool> _checkInternetConnectivity() async {
    // You can use plugins like connectivity to check internet connectivity
    // For simplicity, this example uses a Future that resolves after a delay
    await Future.delayed(Duration(seconds: 2));
    return false; // Change this to your actual implementation
  }

  // Method to fetch data from API
  Future<List<DatabaseCategoryModel>> _fetchDataFromAPI() async {
    // Implement your API fetching logic here
    // This is just a placeholder
    return List.generate(5, (index) => DatabaseCategoryModel(
      id: index + 1,
      name: 'Category ${index + 1}',
      description: 'Description of Category ${index + 1}',
    ));
  }
}