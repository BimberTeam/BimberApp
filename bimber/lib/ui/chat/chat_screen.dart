import 'package:bimber/models/chat_message.dart';
import 'package:bimber/ui/chat/chat_input.dart';
import 'package:bimber/ui/chat/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ChatScreen extends StatefulWidget {
  final List<ChatMessage> messages;
  final String currentUserId;

  const ChatScreen({Key key, this.messages, this.currentUserId});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> currentMessages = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    currentMessages = widget.messages;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
          reverse: true,
          controller: scrollController,
          itemBuilder: (context, index) {
            return ChatMessageWidget(
              message: currentMessages[index],
              isReceived: widget.currentUserId != currentMessages[index].sender,
              showUser: index == 0  || (
                  (currentMessages[index].sender !=
                      currentMessages[index - 1].sender)),
            );
          },
          itemCount: currentMessages.length,
        )),
        ChatInput(
          onSubmitted: (val) {},
        )
      ],
    );
  }
}
