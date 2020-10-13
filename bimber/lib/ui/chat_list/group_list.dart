import 'package:bimber/models/chat_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bimber/ui/common/extensions.dart';

class GroupChatList extends StatelessWidget {
  final List<ChatThumbnail> chatThumbnails;

  GroupChatList({@required this.chatThumbnails});

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
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: chatThumbnails
                      .map((chat) => ChatOverview(chatThumbnail: chat))
                      .toList())),
        )
      ],
    ));
  }
}

class ChatOverview extends StatefulWidget {
  final ChatThumbnail chatThumbnail;

  ChatOverview({@required this.chatThumbnail});

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
    widget.chatThumbnail.checkIfRead().then((value) => setState(() {
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
          widget.chatThumbnail.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        subtitle: Text(
          widget.chatThumbnail.lastMessage?.text ?? "Zacznij konwersacje",
          style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              fontFamily: 'Baloo'),
        ),
        trailing: Column(
          children: <Widget>[
            Text(
              widget.chatThumbnail.lastMessage != null
                  ? DateFormat('kk:mm')
                      .format(widget.chatThumbnail.lastMessage.date)
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
