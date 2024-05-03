import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:offline_database_crud/Api/Data/Response/fetch_data_response.dart';
import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';
import 'package:http/http.dart' as http;
class CategoryProvider extends ChangeNotifier {


final _apidata = HomeViewModel();
  final TextEditingController _nameController = TextEditingController();
   TextEditingController get nameController => _nameController; 
   final TextEditingController _descriptionController = TextEditingController();
   TextEditingController get descriptionController => _descriptionController;
  List<DatabaseCategoryModel> _categories = [];
  List<DatabaseCategoryModel> get categories => _categories;
   bool _isLoading = false;

  bool get isLoading => _isLoading;
  int _catId = 0;
     int get catIdGet => _catId;

  void setCatId(int? id) {
    _catId = id!;
    notifyListeners();
  }
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

   Future<void> fetchCategoryList() async {
    setLoading(true);
    try {
      var url = Uri.parse('https://thesuperstarshop.com/api/v2/category');
      var response = await http.get(url, headers: {
         'Authorization': 'Bearer 142786|AeOu3OznofvA1VHhoqNcVsTZMSRI6AblnZGK8vq45579f341',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var categoriesData = data['data']['data'] as List; // Adjust according to your actual API structure
        log('categoriesData ${categoriesData}');
        List<DatabaseCategoryModel>  categoriesList = categoriesData.map((category) => DatabaseCategoryModel.fromMap(category)).toList();
        log('Fetched Categories: $categoriesList');

         // Update _categories with the fetched categoryList
          _categories = categoriesList;
    
        // Log the fetched categories
        log('Provider Data >> ${_categories}');
        await SQLHelper.storeCategories(categoriesList);
             // Fetch categories from the offline database
    _categories = await SQLHelper.getCategories();
    
    // Log the categories fetched from the offline database
    log('Database Data >> ${_categories}');

      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      setLoading(false);
    }
  }




Future<void> createCategory(String name, String description) async {
  try {
    // Fetch categories from the database
    List<DatabaseCategoryModel> categories = await SQLHelper.getCategories();

    // Get the last ID
    int lastId = categories.isNotEmpty ? categories.last.id : 0;

    // Assign the ID for the new category
    int newCategoryId = lastId + 1;

    // Create a new DatabaseCategoryModel instance
    DatabaseCategoryModel newCategory = DatabaseCategoryModel(
      name: name,
      description: description,
      id: newCategoryId,
    );

    // Add the new category to the database
    await SQLHelper.createCategory(newCategory);

    // Call the API to add the category on the server
    await _apidata.postCategoryListFromAPI(name, description);
    log('Server Data >>>> Category added successfully');

    await fetchCategoryList();
  } catch (error) {
    print('Error creating category: $error');
    throw Exception('Error creating category: $error');
  }
}

///// UPDATE CATEGORY //////
  void updateCategory(DatabaseCategoryModel val){
    if(kDebugMode){
   print('Category Data : ${val.id} >> ${val.name} >>>${val.description}');
    }
    for(DatabaseCategoryModel categories in _categories){
      if(categories.id==val.id){
       setCatId(val.id);
       categories.name!=val.name;
       categories.description!=val.description;
      }
    }
  }


  ///// DELETE CATEGORY //////
    Future<void> deleteCategory(int id) async {
    try {
      // Delete category from local database
      await SQLHelper.deleteCategory(id);

      // Update the list of categories in the provider
      _categories.removeWhere((category) => category.id == id);

      // Notify listeners that the data has changed
      notifyListeners();

      print('Category deleted successfully');
    } catch (e) {
      print('Error deleting category: $e');
      throw Exception('Error deleting category: $e');
    }
  }
  // // Method to check internet connectivity
  // Future<bool> _checkInternetConnectivity() async {
  //   // You can use plugins like connectivity to check internet connectivity
  //   // For simplicity, this example uses a Future that resolves after a delay
  //   await Future.delayed(const Duration(seconds: 0));
  //   return false; // Change this to your actual implementation
  // }

  // // Method to fetch data from API
  // Future<List<DatabaseCategoryModel>> _fetchDataFromAPI() async {
  //   // Implement your API fetching logic here
  //   // This is just a placeholder
  //   return List.generate(5, (index) => DatabaseCategoryModel(
  //     id: index + 1,
  //     name: 'Category ${index + 1}',
  //     description: 'Description of Category ${index + 1}',
  //   ));
  // }
}





// import 'dart:developer';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:offline_database_crud/Api/Data/Response/api_response.dart';
// import 'package:offline_database_crud/Api/Data/Response/fetch_data_response.dart';
// import 'package:offline_database_crud/Api/Models/category_model.dart';
// import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
// import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';
// import 'package:offline_database_crud/Repository/home_repository.dart';
// import 'package:provider/provider.dart';

// class CategoryProvider extends ChangeNotifier {
//   // ...

//   final HomeViewModel _apidata = HomeViewModel();
//   final _repodata = HomeRepository();

//   TextEditingController _nameController = TextEditingController();
//   TextEditingController get nameController => _nameController;
//   TextEditingController _descriptionController = TextEditingController();
//   TextEditingController get descriptionController => _descriptionController;
//   List<DatabaseCategoryModel> _categories = [];
//   List<DatabaseCategoryModel> get categories => _categories;
//   bool _isLoading = true;

//   bool get isLoading => _isLoading;
//   int _catId = 0;
//   int get catIdGet => _catId;

//   void setCatId(int? id) {
//     _catId = id!;
//     notifyListeners();
//   }

//   setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
// Future<void> fetchCategoriesFromDatabase() async {
//     try {
//         // Fetch categories from the API
//         final CategoryModel categoryResponse = await _repodata.fechCategoryList();
//         print('Fetched from API: ${categoryResponse.data!.length}');

//         if (categoryResponse.data != null && categoryResponse.data!.isNotEmpty) {
//             List<DatabaseCategoryModel> databaseCategories = categoryResponse.data!
// .map((datum) => DatabaseCategoryModel(
// id: datum.id ?? 0, // Handle potential null IDs
// name: datum.name ?? '', // Handle potential null names
// description: datum.description ?? '' // Handle potential null descriptions
// )).toList();
//         print('Converted categories for database storage: $databaseCategories');
//         await SQLHelper.storeCategories(databaseCategories as CategoryModel);

//         _categories = await SQLHelper.getCategories();
//         print('Categories updated in the provider: $_categories');
//     } else {
//         _categories = [];
//         print('API returned empty data set.');
//     }
//     notifyListeners();
// } catch (error) {
//     print('Error during fetch and store operation: $error');
//     _categories = await SQLHelper.getCategories();
//     notifyListeners();
// }
// }






  // Future<void> fetchCategoriesFromDatabase() async {
  //   try {
  //     // Call the method to get categories from the database
  //     final categories = await _apidata.fetchCategoryListFromAPI();
  //     await SQLHelper.storeCategories(categories as List<DatabaseCategoryModel>);
  //     _categories = await SQLHelper.getCategories();
  //     log('Get Data >> ${_categories}');
  //     // Notify listeners that the data has been updated
  //     _categories = categories.cast<DatabaseCategoryModel>();
  //     notifyListeners();
  //   } catch (error) {
  //     // Handle any errors
  //     _categories = await SQLHelper.getCategories();
      
  //     print('Error fetching categories from database: $error');
  //   }
  // }

  // Future<void> fetchCategoryList() async {
  //   try {
  //     // Check internet connectivity
  //     bool isConnected = await _checkInternetConnectivity();

  //     if (isConnected) {
  //       // Fetch data from API
  //       final categories = await _repodata.fechCategoryList();

  //       // Store data in offline database
  //       await SQLHelper.storeCategories(categories.data!.cast<CategoryDatum>());

  //       // Update categories list
  //       _categories = categories.data!.cast<DatabaseCategoryModel>();

  //     } else {
  //       // Fetch data from offline database
  //       _categories = await SQLHelper.getCategories();
  //     }

  //     // Notify listeners
  //     notifyListeners();
  //   } catch (error) {
  //     print('Error fetching categories: $error');
  //     throw Exception('Error fetching categories: $error');
  //   }
  // }

// Future<void> createCategory(String name, String description) async {
//   try {
//     // Fetch categories from the database
//     List<DatabaseCategoryModel> categories = await SQLHelper.getCategories();

//     // Get the last ID
//     int lastId = categories.isNotEmpty ? categories.last.id : 0;

//     // Assign the ID for the new category
//     int newCategoryId = lastId + 1;

//     // Create a new DatabaseCategoryModel instance
//     DatabaseCategoryModel newCategory = DatabaseCategoryModel(
//       name: name,
//       description: description,
//       id: newCategoryId,
//     );

//     // Add the new category to the database
//     await SQLHelper.createCategory(newCategory);

//     // Call the API to add the category on the server
//     await _apidata.postCategoryListFromAPI(name, description);
//     log('Server Data >>>> Category added successfully');

//     await fetchCategoryList();
//   } catch (error) {
//     print('Error creating category: $error');
//     throw Exception('Error creating category: $error');
//   }
// }

// ///// UPDATE CATEGORY //////
//   void updateCategory(DatabaseCategoryModel val){
//     if(kDebugMode){
//    print('Category Data : ${val.id} >> ${val.name} >>>${val.description}');
//     }
//     for(DatabaseCategoryModel categories in _categories){
//       if(categories.id==val.id){
//        setCatId(val.id);
//        categories.name!=val.name;
//        categories.description!=val.description;
//       }
//     }
//   }

//   ///// DELETE CATEGORY //////
//     Future<void> deleteCategory(int id) async {
//     try {
//       // Delete category from local database
//       await SQLHelper.deleteCategory(id);

//       // Update the list of categories in the provider
//       _categories.removeWhere((category) => category.id == id);

//       // Notify listeners that the data has changed
//       notifyListeners();

//       print('Category deleted successfully');
//     } catch (e) {
//       print('Error deleting category: $e');
//       throw Exception('Error deleting category: $e');
//     }
//   }
  // Method to check internet connectivity
  // Future<bool> _checkInternetConnectivity() async {
  //   // You can use plugins like connectivity to check internet connectivity
  //   // For simplicity, this example uses a Future that resolves after a delay
  //   await Future.delayed(const Duration(seconds: 0));
  //   return false; // Change this to your actual implementation
  // }

  // // Method to fetch data from API
  // Future<List<DatabaseCategoryModel>> _fetchDataFromAPI() async {
  //   // Implement your API fetching logic here
  //   // This is just a placeholder
  //   return List.generate(5, (index) => DatabaseCategoryModel(
  //     id: index + 1,
  //     name: 'Category ${index + 1}',
  //     description: 'Description of Category ${index + 1}',
  //   ));
  // }
//}
