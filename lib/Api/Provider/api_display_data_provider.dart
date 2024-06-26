import 'dart:convert';
import 'dart:developer';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:offline_database_crud/Api/Data/Network/base_api_service.dart';
import 'package:offline_database_crud/Api/Data/Network/network_api_service.dart';
import 'package:offline_database_crud/Api/Data/Response/fetch_data_response.dart';
import 'package:offline_database_crud/Api/Models/category_model.dart';
import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';
import 'package:http/http.dart' as http;
import 'package:offline_database_crud/Repository/home_repository.dart';
import 'package:offline_database_crud/Res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CategoryProvider extends ChangeNotifier {

BaseApiServices _apiServices = NetworkApiService();
final _apidata = HomeViewModel();
  final TextEditingController _nameController = TextEditingController();
   TextEditingController get nameController => _nameController; 
   final TextEditingController _descriptionController = TextEditingController();
   TextEditingController get descriptionController => _descriptionController;
  List<DatabaseCategoryModel> _categories = [];
  List<DatabaseCategoryModel> get categories => _categories;
   bool _isLoading = false;
   bool _buttonLoading = false;
   bool get buttonLoading => _buttonLoading;
     void setButtonLoading(bool value) {
    _buttonLoading = value;
    notifyListeners();
  }
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

Future<List<DatabaseCategoryModel>> fetchCategoryList() async {
  setLoading(true);
  try {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // Fetch categories from the API
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.categoryGetDataEndPoint);
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        List<dynamic> responseData = response['data'];
        List<DatabaseCategoryModel> categories = responseData.map((categoryData) {
          return DatabaseCategoryModel.fromMap(categoryData);
        }).toList();
        await SQLHelper.storeCategories(categories);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isFetchedCategories", true);
        _categories = categories; // Assign fetched categories
        notifyListeners(); // Notify listeners about the change
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } else {
      // No internet connection, load categories from the local database
      _categories = await SQLHelper.getCategories();
      log('Loaded categories from offline storage');
      notifyListeners(); // Notify listeners about the change
      return _categories;
    }
  } catch (e) {
    // Handle any errors
    print('Error fetching categories: $e');
    throw e; // Rethrow the error to be handled by the caller
  } finally {
    // Ensure that setLoading is always set to false
    setLoading(false);
  }
}


// Future<void> fetchCategoryList() async {
//     setLoading(true);
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult != ConnectivityResult.none) {
//       try {
//         var url = Uri.parse('https://thesuperstarshop.com/api/v2/category?category_type=product&type=get');
//         var response = await http.get(url, headers: {
//           'Authorization': 'Bearer 142786|AeOu3OznofvA1VHhoqNcVsTZMSRI6AblnZGK8vq45579f341',
//           'Content-Type': 'application/json',
//         });

//         if (response.statusCode == 200) {
//           var data = jsonDecode(response.body);
//           var categoriesData = data['data'] as List;
//           _categories = categoriesData.map((category) => DatabaseCategoryModel.fromMap(category)).toList();

//           log('Fetched Categories: $_categories');
//           await SQLHelper.storeCategories(_categories);
    
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           prefs.setBool("isFetchedCategories", true);
//         } else {
//           throw Exception('Failed to load categories');
//         }
//       } catch (e) {
//         print('Error fetching categories: $e');
//       }
//     } else {
//       // No internet connection
//       _categories = await SQLHelper.getCategories();
//       log('Loaded categories from offline storage');
//     }
//     setLoading(false);
//   }




Future<void> createCategory(String name, String description) async {
  try {
    setButtonLoading(true);
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
  setButtonLoading(false);
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
}
