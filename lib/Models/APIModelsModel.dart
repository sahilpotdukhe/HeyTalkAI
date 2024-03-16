class APIModelsModel {
  String id = "";
  late int created;

  APIModelsModel({required this.id, required this.created});

  factory APIModelsModel.fromJSONAPI(Map<String, dynamic> jsonResponse) {
    return APIModelsModel(
        id: jsonResponse['id'],
        created: jsonResponse['created']);
  }

  static List<APIModelsModel> modelFromSnapshot(List modelSnapshot) {
    return modelSnapshot
        .map((jsonResponseData) => APIModelsModel.fromJSONAPI(jsonResponseData))
        .toList();
  }
}
