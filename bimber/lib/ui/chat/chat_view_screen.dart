import 'package:bimber/bloc/chat_bloc/chat_bloc.dart';
import 'package:bimber/models/chat_message.dart';
import 'package:bimber/ui/chat/chat_input.dart';
import 'package:bimber/ui/chat/chat_message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewScreen extends StatefulWidget {
  final List<ChatMessage> messages;
  final String currentUserId;
  final String groupId;

  const ChatViewScreen(
      {Key key, this.messages, this.currentUserId, this.groupId});

  @override
  State<StatefulWidget> createState() => _ChatViewScreenState();
}

class _ChatViewScreenState extends State<ChatViewScreen> {
  List<ChatMessage> currentMessages = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    currentMessages = widget.messages;
  }

  _onSubmitted(BuildContext context) {
    final chatBloc = context.bloc<ChatBloc>();
    return (message) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 100), curve: Curves.easeIn);

      chatBloc.add(SendChatMessage(groupId: widget.groupId, message: message));
    };
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
            final message = currentMessages[index];
            bool hasNext = index + 1 < currentMessages.length;
            final nextMessage = hasNext ? null : currentMessages[index + 1];

            return ChatMessageBox(
              message: message,
              // THIS IS SO FUCKED UP
              isReceived: widget.currentUserId != message.userId,
              showUser: index == currentMessages.length - 1 ||
                  ((message.userId != nextMessage.userId)),
              showDate: index == currentMessages.length - 1 ||
                  (message.date
                          .difference(currentMessages[index + 1].date)
                          .compareTo(Duration(hours: 1)) >
                      0),
            );
          },
          itemCount: currentMessages.length,
        )),
        ChatInput(onSubmitted: _onSubmitted(context))
      ],
    );
  }
}
