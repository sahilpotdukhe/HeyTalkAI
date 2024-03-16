import 'dart:convert';
import 'dart:io';

import 'package:heytalkai/Models/APIModelsModel.dart';
import 'package:heytalkai/Utilities/APIConstants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<APIModelsModel>> getModelsFromAPI() async {
    try {
      var response = await http.get(
          Uri.parse("https://api.openai.com/v1/models"),
          headers: {'Authorization': 'Bearer $OPENAI_API_KEY'});
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponseError: ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }
      List jsonResponseDataList = [];
      for (var item in jsonResponse['data']) {
        jsonResponseDataList.add(item);
        // print(item['id']);
      }
      // print("Json Response:\n $jsonResponse");
      return APIModelsModel.modelFromSnapshot(jsonResponseDataList);
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}
