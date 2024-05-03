import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:offline_database_crud/Api/Data/Network/base_api_service.dart';
import 'package:offline_database_crud/Api/Data/app_exception.dart';



class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
var headers = {
  'Accept': 'application/json',
  'Authorization': 'Bearer 142786|AeOu3OznofvA1VHhoqNcVsTZMSRI6AblnZGK8vq45579f341'
};
      var response = await http.get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    log('responseJson get pi >>> $responseJson');
    
    return responseJson;
  }

    @override
Future<dynamic> getPostApiResponse(String url, String name, String description) async {
  try {
var headers = {
  'Accept': 'application/json',
  'Authorization': 'Bearer 142786|AeOu3OznofvA1VHhoqNcVsTZMSRI6AblnZGK8vq45579f341'
};
    Response response = await post(
      Uri.parse(url),
      body: {
        'name': name,
        'description': description,
      },
      headers: headers,
    ).timeout(const Duration(seconds: 20));

    // Log the status code and response body
    log('Status Code: ${response.statusCode}');
    log('Response Body: ${response.body}');

    // Check the status code and return the appropriate response
    return returnResponse(response);
  } on SocketException {
    throw FetchDataException('No Internet Connection');
  }
}
 



   //// Update Category Using Post Api ////
  Future<http.Response> updateCategoryData(
      int categoryId, String catName, String catDes) async {
var headers = {
  'Accept': 'application/json',
  'Authorization': 'Bearer 142786|AeOu3OznofvA1VHhoqNcVsTZMSRI6AblnZGK8vq45579f341'
};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://thesuperstarshop.com/api/v2/category-update/$categoryId'));
    request.fields.addAll({'name': catName, 'description': catDes});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return await http.Response.fromStream(response);
  }



  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        
        
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while communicating with server with status code ${response.statusCode}');
    }
  }
}

