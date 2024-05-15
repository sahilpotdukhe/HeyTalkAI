import 'package:flutter/material.dart';
import 'package:heytalkai/Models/OnBoardModel.dart';
import 'package:heytalkai/Screens/HomeScreen.dart';
import 'package:heytalkai/Utilities/Constants.dart';
import 'package:heytalkai/Utilities/ScreenDimensions.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardScreens extends StatefulWidget {
  const OnBoardScreens({super.key});

  @override
  State<OnBoardScreens> createState() => _OnBoardScreensState();
}

class _OnBoardScreensState extends State<OnBoardScreens> {
  int currentIndex = 0;
  late PageController _pageController =PageController();

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnBoardInfo() async{
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("OnBoard", isViewed);
  }

  List<OnBoardModel> screens = <OnBoardModel>[
    OnBoardModel(
      image: 'assets/Imagegeneration.json',
      text: "Imagination to Reality",
      description:"Welcome to HeyTalkAI! Just imagine anything and Share your thoughts, and watch the magic unfold!"
    ),
    OnBoardModel(
      image: 'assets/brainsplash.json',
      text: "Ask me anything",
      description:"Meet our AI-powered chatbot! Get personalized responses instantly. Experience the future of chatting today!",
    ),
    OnBoardModel(
      image: 'assets/languagetranslation.json',
      text: "AI-Powered Language Translation",
      description: "Break language barriers effortlessly with our AI chatbot. Translate any language to any instantly!",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    ScaleUtils.init(context);
    return Scaffold(
      backgroundColor: (currentIndex%2 ==0 )?Colors.black: Colors.white,
      appBar: AppBar(
        backgroundColor:(currentIndex%2 ==0 )?Colors.black: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () async{
                await _storeOnBoardInfo();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              },
              child: Text("Skip",
                style: TextStyle(
                  fontSize: 20.0*ScaleUtils.scaleFactor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: AppColors.appThemeColor,
                ),
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20*ScaleUtils.horizontalScale),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            // physics: NeverScrollableScrollPhysics(),
            onPageChanged: (int index){
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(screens[index].image),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27.0*ScaleUtils.scaleFactor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: index % 2 == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    screens[index].description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17.0*ScaleUtils.scaleFactor,
                      fontFamily: 'Montserrat',
                      color: index % 2 == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10*ScaleUtils.verticalScale,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 3*ScaleUtils.horizontalScale),
                              width: currentIndex == index ?25*ScaleUtils.horizontalScale : 8*ScaleUtils.horizontalScale,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: currentIndex == index && currentIndex % 2 ==0 ? AppColors.appThemeColor: Colors.green[200],
                                  borderRadius: BorderRadius.circular(10*ScaleUtils.scaleFactor)
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () async{
                      if(index == screens.length -1 ){
                        await _storeOnBoardInfo();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                      }
                      _pageController.nextPage(duration: Duration(microseconds: 500), curve: Curves.bounceIn);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30*ScaleUtils.horizontalScale,vertical: 10*ScaleUtils.verticalScale),
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? AppColors.appThemeColor : Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Text((index == screens.length -1 )?"Finish":"Next",
                          style: TextStyle(
                            fontSize: 16.0*ScaleUtils.scaleFactor,
                            color: Colors.white ,
                          ),
                          ),
                          SizedBox(width: 15*ScaleUtils.horizontalScale,),
                          Icon(Icons.arrow_forward_sharp,color: Colors.white ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
        ),
      )
    );
  }
}
