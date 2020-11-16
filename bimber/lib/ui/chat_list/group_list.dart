import 'package:bimber/bloc/chat_list/chat_list_bloc.dart';
import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/ui/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bimber/ui/common/extensions.dart';
import 'package:build_context/build_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              child: chatThumbnails.isNotEmpty
                  ? ListView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      scrollDirection: Axis.vertical,
                      children: chatThumbnails
                          .map((chat) => ChatOverview(chatThumbnail: chat))
                          .toList())
                  : LayoutBuilder(builder: (BuildContext context,
                      BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Container(
                              height: viewportConstraints.maxHeight,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Brak grup",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Baloo'),
                                  textAlign: TextAlign.center,
                                ),
                              )));
                    })),
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
  void didUpdateWidget(oldWidget) {
    _init();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    bool isRead = await widget.chatThumbnail.checkIfRead();
    if (this.mounted) {
      setState(() {
        read = isRead;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          widget.chatThumbnail.markAsRead();
          context
              .pushNamed("/chat", arguments: widget.chatThumbnail)
              .then((_) => context.bloc<ChatListBloc>().add(RefreshChatList()));
        },
        contentPadding: EdgeInsets.all(10),
        leading: CircleAvatar(
          backgroundColor: colorFromGroupId(widget.chatThumbnail.groupId),
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
          widget.chatThumbnail.lastMessage?.message ?? "Zacznij konwersacje",
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
