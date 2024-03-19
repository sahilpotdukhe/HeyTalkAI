import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heytalkai/Provider/ChatProvider.dart';
import 'package:heytalkai/Provider/ModelsProvider.dart';
import 'package:heytalkai/Services/Services.dart';
import 'package:heytalkai/Utilities/Constants.dart';
import 'package:heytalkai/Widgets/ChatWidgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textController = TextEditingController();
  bool isTyping = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HeyTalk AI",
          style: GoogleFonts.slabo13px(
              fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppColors.appThemeColor,
        actions: [
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                Services.showModalSheet(context: context);
              })
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(children: [
          Flexible(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: chatProvider.getChatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    message: chatProvider.getChatList[index].content,
                    index: chatProvider.getChatList[index].chatIndex,
                  );
                }),
          ),
          (isTyping)
          ?Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Lottie.asset('assets/chattingavatarbot.json'),
                  )),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(15))),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText("Please wait...")
                        ],
                        isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        repeatForever: false,
                        totalRepeatCount: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ):Container(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                  hintText: 'Message HeyTalkAI..',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                  labelText: 'Type your message',
                  floatingLabelStyle:
                      TextStyle(fontSize: 18, color: Colors.white),
                  labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: AppColors.appThemeColor,
                    ),
                    onPressed: () async {
                      await sendMessage(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider);
                    },
                    color: Colors.white,
                  )),
              onSubmitted: (value) async {
                await sendMessage(
                    modelsProvider: modelsProvider, chatProvider: chatProvider);
              },
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }

  Future<void> sendMessage(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    try {
      if (isTyping) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("You can't send multiple message at a time"),
          backgroundColor: Colors.red,
        ));
        return;
      }
      if (textController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please type a message"),
          backgroundColor: Colors.red,
        ));
        return;
      }
      setState(() {
        isTyping = true;
      });
      print("isTyping $isTyping");
      String userMessage = textController.text;
      textController.clear();
      FocusScope.of(context).requestFocus(FocusNode());

      chatProvider.addUserMessage(userMessage: userMessage);
      log('request has been sent');

      await chatProvider.sendMessageToAPIGetAnswer(
          userMessage: userMessage, modelName: modelsProvider.getCurrentModel);

      // setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        isTyping = false;
      });
      Future.delayed(Duration(seconds: 1), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }
}
