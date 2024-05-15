import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heytalkai/Screens/ChatScreen.dart';
import 'package:heytalkai/Screens/ImageGenerationScreen.dart';
import 'package:heytalkai/Screens/LanguageTranslate.dart';
import 'package:heytalkai/Utilities/Constants.dart';
import 'package:heytalkai/Utilities/ScreenDimensions.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScaleUtils.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.grey,
        elevation: 1,
        backgroundColor: AppColors.appThemeColor,
        title: Text(
          'AI Assistants',
          style: GoogleFonts.notoSansWancho(),
        ),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
            },
            child: Padding(
              padding:  EdgeInsets.fromLTRB(24*ScaleUtils.horizontalScale, 20*ScaleUtils.verticalScale, 24*ScaleUtils.horizontalScale, 10*ScaleUtils.verticalScale),
              child: Container(
                height: 140*ScaleUtils.verticalScale,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20*ScaleUtils.scaleFactor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Lottie.asset('assets/ai_ask_me.json'),
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.appThemeColor,
                          borderRadius: BorderRadius.circular(17*ScaleUtils.scaleFactor),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(
                              vertical: 10.0*ScaleUtils.verticalScale, horizontal: 14*ScaleUtils.horizontalScale),
                          child: Text("AI ChatBot",
                              style:
                                  TextStyle(fontSize: 16*ScaleUtils.scaleFactor, color: Colors.white)),
                        )),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageGenerationScreen()));
            },
            child: Padding(
              padding:  EdgeInsets.fromLTRB(24*ScaleUtils.horizontalScale, 20*ScaleUtils.verticalScale, 24*ScaleUtils.horizontalScale, 10*ScaleUtils.verticalScale),
              child: Container(
                height: 140*ScaleUtils.verticalScale,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20*ScaleUtils.scaleFactor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.appThemeColor,
                          borderRadius: BorderRadius.circular(17*ScaleUtils.scaleFactor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0*ScaleUtils.verticalScale, horizontal: 14*ScaleUtils.horizontalScale),
                          child: Text("Generate Image",
                              style:
                                  TextStyle(fontSize: 16*ScaleUtils.scaleFactor, color: Colors.white)),
                        )),
                    Lottie.asset('assets/image.json'),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguageTranslate()));
            },
            child: Padding(
              padding:  EdgeInsets.fromLTRB(24*ScaleUtils.horizontalScale, 20*ScaleUtils.verticalScale, 24*ScaleUtils.horizontalScale, 10*ScaleUtils.verticalScale),
              child: Container(
                height: 140*ScaleUtils.verticalScale,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20*ScaleUtils.scaleFactor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 130*ScaleUtils.verticalScale,
                        child: Lottie.asset('assets/languagetranslation.json')),
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.appThemeColor,
                          borderRadius: BorderRadius.circular(17*ScaleUtils.scaleFactor),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(
                              vertical: 10.0*ScaleUtils.verticalScale, horizontal: 14*ScaleUtils.horizontalScale),
                          child: Text("Language Translator",
                              style:
                                  TextStyle(fontSize: 16*ScaleUtils.scaleFactor, color: Colors.white)),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20*ScaleUtils.horizontalScale,20*ScaleUtils.verticalScale,20*ScaleUtils.horizontalScale,10*ScaleUtils.verticalScale),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20*ScaleUtils.scaleFactor),
                image: DecorationImage(
                  image: AssetImage('assets/AI.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              height: 220*ScaleUtils.verticalScale,
                ),
          )
        ],
      ),
    );
  }
}
