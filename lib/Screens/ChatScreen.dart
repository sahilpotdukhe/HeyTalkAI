import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:heytalkai/Models/ChatModel.dart';
import 'package:heytalkai/Provider/ChatProvider.dart';
import 'package:heytalkai/Provider/ModelsProvider.dart';
import 'package:heytalkai/Services/ApiService.dart';
import 'package:heytalkai/Services/Services.dart';
import 'package:heytalkai/Utilities/Constants.dart';
import 'package:heytalkai/Widgets/ChatWidgets.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textController = TextEditingController();
  bool isTyping = false;
  ScrollController _scrollController = ScrollController();
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
          title: Text("HeyTalk AI"),
          leading: Image.asset('assets/openai_logo.jpg'),
          centerTitle: true,
          backgroundColor: HexColor('15A27F'),
          actions: [
            IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  Services.showModalSheet(context: context);
                })
          ],
        ),
        body: Container(
          color: scaffoldBackgroundColor,
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
                ? SpinKitThreeBounce(
                    color: Colors.white,
                    size: 30,
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                    hintText: 'Message HeyTalkAI..',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                    labelText: 'Type your message',
                    floatingLabelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        await sendMessage(modelsProvider: modelsProvider, chatProvider: chatProvider);
                      },
                      color: Colors.white,
                    )),
                onSubmitted: (value) async {
                  await sendMessage(modelsProvider: modelsProvider, chatProvider: chatProvider);
                },
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please Enter Name';
                //   } else if (!RegExp(r'^[a-z A-Z]+$')
                //       .hasMatch(value)) {
                //     return 'Please enter a valid Name';
                //   }
                //   return null;
                // },
              ),
            )
          ]),
        ));
  }

  Future<void> sendMessage({required ModelsProvider modelsProvider, required ChatProvider chatProvider}) async {
    try {
      if(isTyping){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You can't send multiple message at a time"),backgroundColor: Colors.red,));
        return;
      }
      if(textController.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please type a message"),backgroundColor: Colors.red,));
        return;
      }
      String userMessage = textController.text;
      textController.clear();
      FocusScope.of(context).requestFocus(new FocusNode());
      setState(() {
        isTyping = true;
        chatProvider.addUserMessage(userMessage: userMessage);
      });
      log('request has been sent');
      chatProvider.sendMessageToAPIGetAnswer(userMessage: userMessage, modelName: modelsProvider.getCurrentModel);

      setState(() {});
    } catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),backgroundColor: Colors.red,));
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
