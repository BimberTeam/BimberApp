import 'package:bimber/ui/chat_list/friends_horizontal_list.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          )
      ),
      child: Column(
        children: <Widget>[
          FriendsHorizontalList()
        ],
      )
    );
  }

}