import 'package:bimber/ui/chat_list/friends_horizontal_list.dart';
import 'package:bimber/ui/chat_list/group_list.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            )),
        child: Column(
          children: <Widget>[
            FriendsHorizontalList(friends: Fixtures.getUsersList()),
            GroupChatList(chatList: Fixtures.getChatLists())
          ],
        ));
  }
}
