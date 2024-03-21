import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:heytalkai/Models/APIModelsModel.dart';
import 'package:heytalkai/Models/ChatModel.dart';
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

  static Future<List<ChatModel>> sendMessageToAPI(
      {required String message, required String modelName}) async {
    try {
      var response = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            'Authorization': 'Bearer $OPENAI_API_KEY',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            "model": modelName,
            "messages": [
              {"role": "user", "content": message}
            ]
          }));
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponseError: ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        // log("Response: ${jsonResponse['choices'][0]['message']['content']}");

        chatList = List.generate(
            jsonResponse['choices'].length,
            (index){
              String translatedText = "";
              String contentResponse = jsonResponse['choices'][index]['message']['content'];
              translatedText = utf8.decode(contentResponse.codeUnits);
              return ChatModel(
                  content: translatedText,
                  chatIndex: 1 // 1 for chatBot response
              );
            }

        );
      }
      return chatList;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }

  static Future<String> generateImage({required String userPrompt}) async{
    String imageUrl = "";
    try{
      var response = await http.post(
          Uri.parse("https://api.openai.com/v1/images/generations"),
          headers: {
            'Authorization': 'Bearer $OPENAI_API_KEY',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
              "model": "dall-e-2",
              "prompt": userPrompt,
              "n": 1,
              "size": "1024x1024"
          }));
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponseError: ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }

      imageUrl = jsonResponse['data'][0]['url'];
      print(imageUrl);
      return imageUrl;
    }catch(e){
      print("RRRR $e");
      rethrow;
    }
  }

  static Future<String> translateMessageFromAPI(
      {required String message, required String modelName}) async {
    try {
      var response = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            'Authorization': 'Bearer $OPENAI_API_KEY',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            "model": modelName,
            "messages": [
              {"role": "user", "content": message}
            ]
          }));
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponseError: ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }

      String translatedText = "";
      if (jsonResponse['choices'].length > 0) {
        translatedText = jsonResponse['choices'][0]['message']['content'];
        log("Response: ${jsonResponse['choices'][0]['message']['content']}");
      }
      return translatedText;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}
