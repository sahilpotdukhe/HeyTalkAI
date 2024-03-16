import 'package:flutter/material.dart';
import 'package:heytalkai/Models/APIModelsModel.dart';
import 'package:heytalkai/Services/ApiService.dart';

class ModelsProvider with ChangeNotifier{
  String currentModel = 'gpt-3.5-turbo';
  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel){
    currentModel = newModel;
    notifyListeners();
  }

  List<APIModelsModel> modelsList = [];

  List<APIModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<APIModelsModel>> getAllModels() async{
    modelsList =await ApiService.getModelsFromAPI();
    return modelsList;
  }
}