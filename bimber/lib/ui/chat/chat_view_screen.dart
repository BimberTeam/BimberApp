import 'package:bimber/bloc/chat_bloc/chat_bloc.dart';
import 'package:bimber/models/chat_message.dart';
import 'package:bimber/ui/chat/chat_input.dart';
import 'package:bimber/ui/chat/chat_message_box.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewScreen extends StatefulWidget {
  final String currentUserId;
  final String groupId;

  const ChatViewScreen({Key key, this.currentUserId, this.groupId});

  @override
  State<StatefulWidget> createState() => _ChatViewScreenState();
}

class _ChatViewScreenState extends State<ChatViewScreen> {
  Set<ChatMessage> messages = Set();
  List<ChatMessage> currentMessages = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  _onSubmitted(BuildContext context) {
    final chatBloc = context.bloc<ChatBloc>();
    return (message) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 100), curve: Curves.easeIn);

      chatBloc.add(SendChatMessage(message: message));
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(listener: (context, state) {
      if (state is ChatMessagesFetched) {
        messages.addAll(state.messages);
        _reorderMessages();
      }
      if (state is ChatError) {
        showErrorSnackbar(context, message: state.message);
      }
      if (state is NewChatMessage) {
        messages.add(state.message);
        _reorderMessages();
      }
    }, builder: (context, state) {
      if (state is ChatFetchLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return _view(context);
    });
  }

  _reorderMessages() {
    setState(() {
      currentMessages = messages.toList();
      currentMessages.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  Widget _view(BuildContext context) {
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
