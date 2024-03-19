import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heytalkai/Screens/ChatScreen.dart';
import 'package:heytalkai/Screens/ImageGenerationScreen.dart';
import 'package:heytalkai/Screens/LanguageTranslate.dart';
import 'package:heytalkai/Utilities/Constants.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Lottie.asset('assets/ai_ask_me.json'),
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.appThemeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 18),
                          child: Text("AI ChatBot",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
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
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.appThemeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 18),
                          child: Text("Generate Image",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
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
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 130,
                        child: Lottie.asset('assets/languagetranslation.json')),
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.appThemeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 18),
                          child: Text("Language Translator",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20,20,20,0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/AI.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              height: 250,
                ),
          )
        ],
      ),
    );
  }
}
