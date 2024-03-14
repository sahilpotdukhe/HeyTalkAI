import 'package:flutter/material.dart';

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
    return Container(
      color: (widget.index == 0) ? Colors.blue : Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: (widget.index == 0)
                  ? AssetImage('assets/user.jpg')
                  : AssetImage('assets/chat_logo.png'),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.message),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: (widget.index == 0)
                ? Container()
                : Row(
                    children: const [
                      Icon(Icons.thumb_up_alt_outlined),
                      Icon(Icons.thumb_down_alt_outlined)
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
