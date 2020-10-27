import 'package:bimber/models/chat_message.dart';
import 'package:bimber/ui/chat/chat_input.dart';
import 'package:bimber/ui/chat/chat_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final List<ChatMessage> messages;
  final String currentUserId;
  final String groupId;

  const ChatScreen({Key key, this.messages, this.currentUserId, this.groupId});

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
              showUser: index == currentMessages.length - 1 ||
                  ((currentMessages[index].sender !=
                      currentMessages[index + 1].sender)),
              showDate: index == currentMessages.length - 1 ||
                  (currentMessages[index]
                          .date
                          .difference(currentMessages[index + 1].date)
                          .compareTo(Duration(hours: 1)) >
                      0),
            );
          },
          itemCount: currentMessages.length,
        )),
        ChatInput(
          onSubmitted: (message) {
            scrollController.animateTo(
                scrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 100),
                curve: Curves.easeIn);
            setState(() {
              currentMessages
                ..insert(
                    0,
                    ChatMessage(
                        id: null,
                        groupId: widget.groupId,
                        date: DateTime.now(),
                        text: message,
                        sender: widget.currentUserId));
            });
          },
        )
      ],
    );
  }
}
