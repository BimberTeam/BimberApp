import 'package:bimber/models/user.dart';
import 'package:bimber/ui/chat_list/friend_holder.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';
import 'package:bimber/bloc/chat_list/chat_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FriendsHorizontalList extends StatelessWidget {
  final List<User> friends;

  FriendsHorizontalList({@required this.friends});

  _menuItem(Function onTap, String text, IconData iconData, Color color) {
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
            FriendHolder(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: UserImageHero(
                    user: user,
                    size: Size(60, 60),
                    onTap: () {
                      context.pushNamed("/user-details", arguments: user);
                    }),
              ),
              menuContent: Column(
                children: [
                  _menuItem(() => {}, "Dodaj do grupy", Icons.add,
                      Theme.of(context).colorScheme.secondary),
                  _menuItem(
                      () {
                        Navigator.pop(context);
                        context.bloc<ChatListBloc>().add(DeleteFriend(friendId: user.id));
                      }, "Usuń ze znajomych", Icons.delete, Colors.red),
                ],
              ),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Znajomi",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Baloo'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: PopupMenuButton(
                      icon: Icon(Icons.more_horiz, color: Colors.white),
                      color: Theme.of(context).colorScheme.primary,
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                            PopupMenuItem(
                                child: _menuItem(
                                    () => {},
                                    "Stwórz grupę",
                                    Icons.create,
                                    Theme.of(context).colorScheme.secondary)),
                            PopupMenuItem(
                                child: _menuItem(
                                    () => {},
                                    "Zaproszenia",
                                    Icons.people_outline,
                                    Theme.of(context).colorScheme.secondary)),
                          ]),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 4.0),
              height: 90,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: friends
                      .map((user) => _memberAvatar(context, user))
                      .toList()))
        ],
      ),
    );
  }
}
