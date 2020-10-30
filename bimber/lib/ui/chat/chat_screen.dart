import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/ui/chat/chat_view_screen.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class ChatScreen extends StatelessWidget {
  final ChatThumbnail chatThumbnail;

  const ChatScreen({this.chatThumbnail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primaryVariant,
        ),
        elevation: 1.0,
        title: Padding(
          padding: EdgeInsets.only(left: 8.00),
          child: Text(
            chatThumbnail.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo'),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              context.pushNamed("/chat-info", arguments: chatThumbnail.groupId);
            },
          ),
        ],
      ),
      body: ChatViewScreen(
        messages: Fixtures.getChatMessages(),
        currentUserId: "id3",
        groupId: chatThumbnail.groupId,
      ), //TODO bloc provider, consumer
    );
  }
}
