import 'package:bimber/models/chat_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bimber/ui/common/extensions.dart';

class GroupChatList extends StatelessWidget {
  final List<ChatThumbnail> chatList;

  GroupChatList({@required this.chatList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            "Grupy",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo'),
          ),
        ),
        Expanded(
          child: Container(
              padding: EdgeInsets.only(left: 4.0),
              child: ListView(
                  scrollDirection: Axis.vertical,
                  children: chatList
                      .map((chat) => ChatOverview(chat: chat))
                      .toList())),
        )
      ],
    ));
  }
}

class ChatOverview extends StatefulWidget {
  final ChatThumbnail chat;

  ChatOverview({@required this.chat});

  @override
  State<StatefulWidget> createState() => ChatOverviewState();
}

class ChatOverviewState extends State<ChatOverview> {
  bool read = true;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    widget.chat.checkIfRead().then((value) => setState(() {
          read = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: CircleAvatar(
          //TODO avatar based on chat.avatarId
          backgroundColor: Colors.pink,
          radius: 30,
        ),
        title: Text(
          widget.chat.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        subtitle: Text(
          widget.chat.lastMessage?.text ?? "Zacznij konwersacje",
          style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        trailing: Column(
          children: <Widget>[
            Text(
              widget.chat.lastMessage != null
                  ? DateFormat('kk:mm').format(widget.chat.lastMessage.date)
                  : "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo'),
            ),
            read
                ? SizedBox()
                : Icon(
                    Icons.new_releases,
                    color: Colors.red,
                    size: 20,
                  )
          ],
        ));
  }
}
