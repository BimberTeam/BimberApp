import 'package:bimber/ui/chat/chat_input.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(child: Container()),
        ChatInput(
          onSubmitted: (val) {},
        )
      ],
    );
  }

}