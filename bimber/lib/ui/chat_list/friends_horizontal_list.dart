import 'package:bimber/models/user.dart';
import 'package:bimber/ui/chat_list/friend_press_detector.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';
import 'package:bimber/bloc/chat_list/chat_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsHorizontalList extends StatelessWidget {
  final List<User> friends;
  final bool newInvitations;

  FriendsHorizontalList(
      {@required this.friends, @required this.newInvitations});

  Widget _menuItem(
      Function onTap, String text, IconData iconData, Color color) {
    return ListTile(
      onTap: onTap,
      leading: Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            fontFamily: 'Baloo'),
      ),
      trailing: Icon(
        iconData,
        color: color,
        size: 15,
      ),
    );
  }

  Widget _memberAvatar(BuildContext context, User user) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            FriendPressDetector(
              child: UserImageHero(
                user: user,
                size: Size(60, 60),
                radius: BorderRadius.circular(15.0),
                onTap: () {
                  context.pushNamed("/user-details", arguments: user);
                },
                showGradient: false,
              ),
              menuContent: _menuItem(() {
                context.pop();
                context
                    .bloc<ChatListBloc>()
                    .add(DeleteFriend(friendId: user.id));
              }, "Usuń ze znajomych", Icons.delete, Colors.red),
            ),
            Text(
              "${user.name}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo'),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Znajomi",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo'),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 4.0),
              height: 90,
              child: friends.isNotEmpty
                  ? ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: friends
                          .map((user) => _memberAvatar(context, user))
                          .toList())
                  : Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Brak znajomych",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Baloo'),
                        textAlign: TextAlign.center,
                      ),
                    )),
          newInvitations
              ? Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.4))
                  ]),
                  child: ListTile(
                    enabled: true,
                    leading: Icon(
                      Icons.people,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Nowe zaproszenia",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Baloo'),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.red,
                      size: 18,
                    ),
                    onTap: () => context.pushNamed("/invitations").then((_) =>
                        context.bloc<ChatListBloc>().add(RefreshChatList())),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
