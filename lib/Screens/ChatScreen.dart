import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:heytalkai/Services/Services.dart';
import 'package:heytalkai/Utilities/Constants.dart';
import 'package:heytalkai/Widgets/ChatWidgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textController = TextEditingController();
  bool isTyping = true;

  @override
  Widget build(BuildContext context) {
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
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      message: chatMessages[index]['msg'].toString(),
                      index: int.parse(
                          chatMessages[index]['chatIndex'].toString()),
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
                      onPressed: () {
                        print("Hello");
                      },
                      color: Colors.white,
                    )),
                keyboardType: TextInputType.name,
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
}
