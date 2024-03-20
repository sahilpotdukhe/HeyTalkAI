import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:heytalkai/Provider/ChatProvider.dart';
import 'package:heytalkai/Provider/LanguageProvider.dart';
import 'package:heytalkai/Provider/ModelsProvider.dart';
import 'package:heytalkai/Screens/HomeScreen.dart';
import 'package:heytalkai/Screens/OnBoardScreens.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 3));
  FlutterNativeSplash.remove();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt("OnBoard");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModelsProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) =>  LanguageProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isViewed != 0 ? OnBoardScreens():HomeScreen()
      ),
    );
  }
}

