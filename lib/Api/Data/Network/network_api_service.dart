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
        'Authorization':
            'Bearer 104407|gocdr6hYQfhq9dKKjdHOtVJH8rWq8j8UQp9388cMcef8108f'
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
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        log(
            'Status Code >>>> ${response.statusCode == 200}   Response Body >>>> ${response.body}');
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

