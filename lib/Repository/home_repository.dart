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
       log('Post Api Data >>> ${response}');
      return response;
    } catch (e) {
      
      throw e;
    }
  }


  // Future<bool> checkConnectivity() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult.contains(ConnectivityResult.mobile) ||
  //       connectivityResult.contains(ConnectivityResult.wifi) ||
  //       connectivityResult.contains(ConnectivityResult.bluetooth) ||
  //       connectivityResult.contains(ConnectivityResult.ethernet) ||
  //       connectivityResult.contains(ConnectivityResult.vpn) ||
  //       connectivityResult.contains(ConnectivityResult.other)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // } 
}




















// import 'dart:developer';

// import 'package:offline_database_crud/Api/Data/Network/base_api_service.dart';
// import 'package:offline_database_crud/Api/Data/Network/network_api_service.dart';
// import 'package:offline_database_crud/Api/Models/category_model.dart';
// import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';
// import 'package:offline_database_crud/Res/app_url.dart';





// class HomeRepository {
//   BaseApiServices _apiServices = NetworkApiService();
//   // Fetch Category  List /////////

//  Future <CategoryModel> fechCategoryList() async {
//     try {
//       dynamic response = await _apiServices.getGetApiResponse(
//         AppUrl.categoryGetDataEndPoint,
//       );
//       log('response getGetApiResponse movies >>> ${response}');
//       await SQLHelper.storeCategories(response);
//       return response = CategoryModel.fromMap(response);
      
//     } catch (e) {
      
//       throw e;
//     }
//   } 






//   //// Post/Add Category  List /////////



//  Future<CategoryModel> postCategoryList(String name, String description) async {
//     try {
//       dynamic response = await _apiServices.getPostApiResponse(
//         AppUrl.categoryADDDataEndPoint,
//         name,
//         description
//       );
//       // log('response getGetApiResponse category >>> ${response}');
//       return response;
//     } catch (e) {
    
//       throw e;
//     }
//   }

//   fetchCategoryListFromAPI() {} 







 

// }
