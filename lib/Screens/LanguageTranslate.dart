import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:heytalkai/Provider/LanguageProvider.dart';
import 'package:heytalkai/Services/ApiService.dart';
import 'package:heytalkai/Utilities/Constants.dart';
import 'package:heytalkai/Utilities/ScreenDimensions.dart';
import 'package:heytalkai/Widgets/LanguageBottomSheet.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LanguageTranslate extends StatefulWidget {
  const LanguageTranslate({super.key});

  @override
  State<LanguageTranslate> createState() => _LanguageTranslateState();
}

class _LanguageTranslateState extends State<LanguageTranslate> {
  TextEditingController textController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  bool isTranslating = false;

  @override
  Widget build(BuildContext context) {
    ScaleUtils.init(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appThemeColor,
        elevation: 2,
        title: Text("Language Translator",
          style: GoogleFonts.slabo13px(
              fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20*ScaleUtils.verticalScale,
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
                    height: 50*ScaleUtils.verticalScale,
                    width: 160*ScaleUtils.horizontalScale,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: HexColor('F7F2F9'),
                      border: Border.all(color: AppColors.appThemeColor,width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(18*ScaleUtils.scaleFactor)),
                    ),
                    child: Text(languageProvider.getFromSelectedLanguage,style: TextStyle(fontSize: 16*ScaleUtils.scaleFactor),)),
              ),
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.repeat, color: Colors.black,)),
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
                    height: 50*ScaleUtils.verticalScale,
                    width: 160*ScaleUtils.horizontalScale,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: HexColor('F7F2F9'),
                      border: Border.all(color: AppColors.appThemeColor,width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(18*ScaleUtils.scaleFactor)),
                    ),
                    child: Text(languageProvider.getToSelectedLanguage,style: TextStyle(fontSize: 16*ScaleUtils.scaleFactor),)),
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.all(20*ScaleUtils.scaleFactor),
            child: Card(
              elevation: 30,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20*ScaleUtils.scaleFactor),
                  color: HexColor('F7F2F9'),
                ),
                child: TextField(
                  controller: textController,
                  minLines: 5,
                  maxLines: null,
                  onTapOutside: (e) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                      hintText: "Translate anything you want",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                          //borderRadius: BorderRadius.all(Radius.circular(20),)
                      )
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () async {
                setState(() {
                  isTranslating = true;
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: Container(
                          width: 300*ScaleUtils.horizontalScale,
                          height: 300*ScaleUtils.verticalScale,
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              Lottie.asset('assets/chattingavatarbot.json',
                                  height: 250*ScaleUtils.verticalScale, width: 250*ScaleUtils.horizontalScale),
                              DefaultTextStyle(
                                  style: TextStyle(
                                      fontSize: 18*ScaleUtils.scaleFactor, color: Colors.white),
                                  child: Text('Translating Text...'))
                            ],
                          ),
                        ),
                      );
                    });
                resultController.text = await translateLanguage(languageProvider);
                setState(() {
                  isTranslating = false;
                });
                Navigator.pop(context);
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.appThemeColor,
                    borderRadius: BorderRadius.circular(18*ScaleUtils.scaleFactor),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(
                        vertical: 10.0*ScaleUtils.verticalScale, horizontal: 16*ScaleUtils.horizontalScale),
                    child: Text("Translate",
                        style:
                        TextStyle(fontSize: 18*ScaleUtils.scaleFactor, color: Colors.white)),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20*ScaleUtils.scaleFactor),
            child: Card(
              elevation: 30,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20*ScaleUtils.scaleFactor),
                  color: HexColor('F7F2F9'),
                ),
                child: TextField(
                  controller: resultController,
                  maxLines: null,
                  readOnly: true,
                  minLines: 5,
                  onTapOutside: (e) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                      hintText: "Output",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
              ),
            ),
          ),
          SizedBox(height: 30*ScaleUtils.verticalScale,),
          Center(
            child: InkWell(
              onTap: () async{
                textController.clear();
                resultController.clear();
                setState(() {});
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(18*ScaleUtils.scaleFactor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10*ScaleUtils.verticalScale, horizontal: 20*ScaleUtils.horizontalScale),
                    child: Text("Clear",
                        style:
                        TextStyle(fontSize: 18*ScaleUtils.scaleFactor, color: Colors.white)),
                  )),
            ),
          ),
          SizedBox(height: 20*ScaleUtils.verticalScale,)
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
