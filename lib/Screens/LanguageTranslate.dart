import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heytalkai/Provider/LanguageProvider.dart';
import 'package:heytalkai/Services/ApiService.dart';
import 'package:heytalkai/Widgets/LanguageBottomSheet.dart';
import 'package:provider/provider.dart';

class LanguageTranslate extends StatefulWidget {
  const LanguageTranslate({super.key});

  @override
  State<LanguageTranslate> createState() => _LanguageTranslateState();
}

class _LanguageTranslateState extends State<LanguageTranslate> {
  TextEditingController textController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Launguage Translator"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return LanguageBottomSheet(parameter: "from");
                      }
                  );
                },
                child: Container(
                    height: 50,
                    width: 180,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text(languageProvider.getFromSelectedLanguage,style: TextStyle(fontSize: 18),)),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.repeat_outlined)),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return LanguageBottomSheet(parameter: "to");
                      }
                  );
                },
                child: Container(
                    height: 50,
                    width: 180,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Text(languageProvider.getToSelectedLanguage,style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: textController,
              minLines: 5,
              maxLines: null,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                  hintText: "Translate anything you want",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          ),
          (textController.text.isNotEmpty)?
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: resultController,
              maxLines: null,
              readOnly: true,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          ): Container(),
          InkWell(
            onTap: () async{
              resultController.text = await translateLanguage(languageProvider);
            },
            child: Center(
              child: Container(
                height: 40,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.blue,
                ),
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text(
                    "Translate",
                    style: TextStyle(color: Colors.white,fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          InkWell(
            onTap: () async{
              textController.clear();
              resultController.clear();
              setState(() {

              });
            },
            child: Center(
              child: Container(
                height: 40,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.red,
                ),
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text(
                    "Clear",
                    style: TextStyle(color: Colors.white,fontSize: 18),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

   Future<String> translateLanguage(LanguageProvider languageProvider) async{
    String fromLanguage = languageProvider.getFromSelectedLanguage;
    String toLanguage = languageProvider.getToSelectedLanguage;
    if(textController.text.trim().isNotEmpty && toLanguage != "To"){
      String prompt = "";
      if(fromLanguage.isNotEmpty && fromLanguage != "Auto"){
        prompt = 'Can you translate given text from $fromLanguage to $toLanguage:\n:${textController.text}';
      }else{
        prompt = 'Can you translate given text $toLanguage:\n${textController.text}';
      }
      String resultFromAPI = "";
      resultFromAPI =  await ApiService.translateMessageFromAPI(message: prompt, modelName: "gpt-3.5-turbo");
      String translatedMessage = "";

      translatedMessage = utf8.decode(resultFromAPI.codeUnits);
      return translatedMessage;
    }else{
        if(toLanguage == "To"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter in which language you want to convert",),backgroundColor: Colors.red,));
          return "Please enter in which language you want to convert";
        }else if(textController.text.trim().isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter any text to convert"),backgroundColor: Colors.red,));
        }
        return "Please enter any text to convert";
    }
  }
}
