import 'package:flutter/material.dart';
import 'package:heytalkai/Provider/ChatProvider.dart';
import 'package:heytalkai/Provider/LanguageProvider.dart';
import 'package:heytalkai/Provider/ModelsProvider.dart';
import 'package:heytalkai/Screens/LanguageTranslate.dart';
import 'package:provider/provider.dart';
import 'package:heytalkai/Screens/ImageGenerationScreen.dart';

void main() {
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
        home: LanguageTranslate()
      ),
    );
  }
}

