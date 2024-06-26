import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heytalkai/Services/ApiService.dart';
import 'package:heytalkai/Utilities/Constants.dart';
import 'package:heytalkai/Utilities/ScreenDimensions.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageGenerationScreen extends StatefulWidget {
  const ImageGenerationScreen({super.key});

  @override
  State<ImageGenerationScreen> createState() => _ImageGenerationScreenState();
}

class _ImageGenerationScreenState extends State<ImageGenerationScreen> {
  TextEditingController imageTextController = TextEditingController();
  String generatedImageurl = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ScaleUtils.init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.appThemeColor,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Image Generator",
          style: GoogleFonts.slabo13px(
              fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10*ScaleUtils.verticalScale,),
          Center(
              child: Padding(
            padding:  EdgeInsets.all(8.0*ScaleUtils.scaleFactor),
            child: Text(
              "Please enter prompt to generate AI Image",
              style: TextStyle(
                  fontSize: 17*ScaleUtils.scaleFactor,
                  color: Colors.white),
            ),
          )),
          Padding(
              padding: EdgeInsets.all(16.0*ScaleUtils.scaleFactor),
              child: TextField(
                controller: imageTextController,
                textAlign: TextAlign.center,
                minLines: 1,
                maxLines: null,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  hintText: 'Type your prompt',
                  hintStyle: TextStyle(
                    fontSize: 16*ScaleUtils.scaleFactor,
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              )),
          SizedBox(height: 10*ScaleUtils.verticalScale,),
          Center(
            child: InkWell(
              onTap: () async {
                if(imageTextController.text.trim() != ""){
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(Duration(seconds: 4));
                  // generatedImageurl =
                  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg9vzIbEZ5gg2BL_s1AnpTHuog4JnTmVvFEnNhe-y2RfA0kELh5aazqfXAgYbs9I6S5fg&usqp=CAU";
                  generatedImageurl = await ApiService.generateImage(
                      userPrompt: imageTextController.text);
                  setState(() {
                    isLoading = false;
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.red,content: Center(child: Text("Please enter prompt"))));
                }

              },
              child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.appThemeColor,
                    borderRadius: BorderRadius.circular(20*ScaleUtils.scaleFactor),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(
                        vertical: 10*ScaleUtils.verticalScale, horizontal: 16*ScaleUtils.horizontalScale),
                    child: Text("Generate Image",
                        style: TextStyle(fontSize: 18*ScaleUtils.scaleFactor, color: Colors.white)),
                  )),
            ),
          ),
          SizedBox(height: 20*ScaleUtils.verticalScale,),
          (isLoading)
              ? Padding(
                  padding:  EdgeInsets.all(18.0*ScaleUtils.scaleFactor),
                  child: Container(
                    child: Lottie.asset('assets/Imagegeneration.json',
                        fit: BoxFit.cover),
                  ),
                )
              : (generatedImageurl != "")
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(18.0*ScaleUtils.horizontalScale, 0, 18*ScaleUtils.horizontalScale, 8*ScaleUtils.verticalScale),
                      child: SizedBox(
                          height: 470*ScaleUtils.verticalScale,
                          width: 470*ScaleUtils.horizontalScale,
                          child: Image.network(
                            generatedImageurl,
                            loadingBuilder: (BuildContext context, Widget image,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return image;
                              return Padding(
                                padding:  EdgeInsets.all(18.0*ScaleUtils.scaleFactor),
                                child: Center(
                                  child: Container(
                                    child: Lottie.asset(
                                        'assets/Imagegeneration.json',
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              );
                            },
                          )),
                    )
                  : Padding(
                      padding:  EdgeInsets.all(18.0*ScaleUtils.scaleFactor),
                      child: Container(
                        child: Lottie.asset('assets/brainsplash.json',
                            fit: BoxFit.cover),
                      ),
                    ),
          (generatedImageurl != "")
          ?Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    shareImage();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.appThemeColor,
                        borderRadius: BorderRadius.circular(18*ScaleUtils.scaleFactor),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                            vertical: 10.0*ScaleUtils.verticalScale, horizontal: 16*ScaleUtils.horizontalScale),
                        child: Row(
                          children:  [
                            Text("Share",
                                style:
                                    TextStyle(fontSize: 17*ScaleUtils.scaleFactor, color: Colors.white)),
                            SizedBox(width: 8*ScaleUtils.horizontalScale,),
                            Icon(Icons.share,color: Colors.white,)
                          ],
                        ),
                      )),
                ),
                InkWell(
                  onTap: () async {
                    downloadImage();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.appThemeColor,
                        borderRadius: BorderRadius.circular(18*ScaleUtils.scaleFactor),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                            vertical: 10*ScaleUtils.verticalScale, horizontal: 16*ScaleUtils.horizontalScale),
                        child: Row(
                          children: [
                            Text("Download",
                                style:
                                    TextStyle(fontSize: 17*ScaleUtils.scaleFactor, color: Colors.white)),
                            SizedBox(width: 8*ScaleUtils.horizontalScale,),
                            Icon(Icons.download_rounded,color: Colors.white,)
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ): Container(),
          SizedBox(height: 20*ScaleUtils.verticalScale,)
        ],
      ),
    );
  }

  void shareImage() async {
    try {
      //To show loading
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: Container(
                width: 300,
                height: 300,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Lottie.asset('assets/AILoader.json',
                        height: 250, width: 250),
                    DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 18, color: AppColors.appThemeColor),
                        child: Text('Sharing Image...'))
                  ],
                ),
              ),
            );
          });

      print('url: $generatedImageurl');

      final bytes = (await get(Uri.parse(generatedImageurl))).bodyBytes;
      final dir = await getTemporaryDirectory();

      final file = await File(
              '${dir.path}/${imageTextController.text}${DateTime.now().microsecondsSinceEpoch}.png')
          .writeAsBytes(bytes);

      print('filePath: ${file.path}');

      //hide loading
      Navigator.pop(context);

      await Share.shareXFiles([XFile(file.path)],
          text:
              'Check out this Amazing Image of ${imageTextController.text} created by HeyTalkAI by Sahil Potdukhe');
    } catch (e) {
      //hide loading
      Navigator.pop(context);
      //MyDialog.error('Something Went Wrong (Try again in sometime)!');
      print('downloadImageError: $e');
    }
  }

  void downloadImage() async{
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: Container(
                width: 300,
                height: 300,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Lottie.asset('assets/AILoader.json',
                        height: 250, width: 250),
                    DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 18, color: AppColors.appThemeColor),
                        child: Text('Downloading Image...'))
                  ],
                ),
              ),
            );
          });
      await Future.delayed(Duration(seconds: 3));

      print('url: $generatedImageurl');

      final bytes = (await get(Uri.parse(generatedImageurl))).bodyBytes;
      final dir = await getTemporaryDirectory();

      final file = await File(
              '${dir.path}/${imageTextController.text}${DateTime.now().microsecondsSinceEpoch}.png')
          .writeAsBytes(bytes);

      print('filePath: ${file.path}');
      //save image to gallery
      await GallerySaver.saveImage(file.path).then((success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Center(
              child: Text(
                "Image Downloaded Successfully",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )));
        //hide loading
        Navigator.pop(context);
      });
    } catch (e) {
      //hide loading
      Navigator.pop(context);
      //MyDialog.error('Something Went Wrong (Try again in sometime)!');
      print('downloadImageError: $e');
    }
  }
}
