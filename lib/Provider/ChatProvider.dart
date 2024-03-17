import 'package:flutter/material.dart';
import 'package:heytalkai/Models/ChatModel.dart';
import 'package:heytalkai/Services/ApiService.dart';

class ChatProvider with ChangeNotifier{
  List<ChatModel> chatList = [];

  List<ChatModel> get getChatList {
    return chatList;
}
void addUserMessage({ required String userMessage}){
  chatList.add(ChatModel(content: userMessage, chatIndex: 0));
  notifyListeners();
}

Future<void> sendMessageToAPIGetAnswer({required String userMessage, required String modelName}) async{
  chatList.addAll(await ApiService.sendMessageToAPI(
      message: userMessage,
      modelName: modelName));
  notifyListeners();
}

}