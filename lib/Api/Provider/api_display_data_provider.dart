import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:offline_database_crud/Api/Data/Response/fetch_data_response.dart';
import 'package:offline_database_crud/Api/Models/category_model.dart';
import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';

class CategoryProvider extends ChangeNotifier {
  // ...

  
final _apidata = HomeViewModel();
  TextEditingController _nameController = TextEditingController();
   TextEditingController get nameController => _nameController; 
   TextEditingController _descriptionController = TextEditingController();
   TextEditingController get descriptionController => _descriptionController;
  List<DatabaseCategoryModel> _categories = [];
  List<DatabaseCategoryModel> get categories => _categories;
    bool _isLoading = true;
  //    List<CategoryDatum> _categoriesModel = [];
  //  List<CategoryDatum> get categoriesList => _categoriesModel;
  bool get isLoading => _isLoading;
  int _catId = 0;
     int get catIdGet => _catId;

  void setCatId(int? id) {
    _catId = id!;
    notifyListeners();
  }
  setLoading(bool value){
    _isLoading = value;
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
  // Method to check internet connectivity
  Future<bool> _checkInternetConnectivity() async {
    // You can use plugins like connectivity to check internet connectivity
    // For simplicity, this example uses a Future that resolves after a delay
    await Future.delayed(const Duration(seconds: 0));
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

