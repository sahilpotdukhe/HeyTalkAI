import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier{
  // From which language
  String fromSelectedLanguage = "Auto";

  String get getFromSelectedLanguage{
    return fromSelectedLanguage;
  }

  void setFromSelectedLanguage(String lang){
    fromSelectedLanguage = lang;
    notifyListeners();
  }
// to which language
  String toSelectedLanguage = "To";

  String get getToSelectedLanguage{
    return toSelectedLanguage;
  }

  void setToSelectedLanguage(String lang){
    toSelectedLanguage = lang;
    notifyListeners();
  }
}