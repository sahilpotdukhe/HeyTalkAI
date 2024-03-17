class ChatModel {
  String content = "";
  late int chatIndex;

  ChatModel({required this.content, required this.chatIndex});

  factory ChatModel.fromJSONAPI(Map<String, dynamic> jsonResponse) {
    return ChatModel(
        content: jsonResponse['content'], chatIndex: jsonResponse['chatIndex']);
  }
}
