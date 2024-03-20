import 'package:flutter/material.dart';
import 'package:heytalkai/Utilities/Constants.dart';
import 'package:lottie/lottie.dart';

class ChatWidget extends StatefulWidget {
  final String message;
  final int index;

  const ChatWidget({super.key, required this.message, required this.index});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
    return (widget.index == 0) ? senderLayout() : receiverLayout();
  }

  Widget senderLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6),
              decoration: BoxDecoration(
                  color: AppColors.appThemeColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(15))),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                  child: Text(
                    widget.message,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Image.asset(
                  'assets/userbg.png',
                  fit: BoxFit.cover,
                ))),
      ],
    );
  }

  Widget receiverLayout() {
    return Row(
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
                child:Text(widget.message)
                //TypeWriterText(text: Text(widget.message), duration: Duration(milliseconds: 10),maintainSize: false,repeat: false,)
                // AnimatedTextKit(
                //   animatedTexts: [
                //     TypewriterAnimatedText(widget.message.trim(),speed: const Duration(milliseconds: 20),),
                //   ],
                //   isRepeatingAnimation: false,
                //   displayFullTextOnTap: true,
                //   repeatForever: false,
                //   totalRepeatCount: 0,
                // ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
