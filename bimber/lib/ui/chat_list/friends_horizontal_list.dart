import 'package:bimber/models/user.dart';
import 'package:bimber/ui/chat_list/friend_holder.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class FriendsHorizontalList extends StatelessWidget {
  Widget _memberAvatar(
      BuildContext context, User user, Color color, double size) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            FriendHolder(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: UserImageHero(
                    user: user,
                    width: size,
                    height: size,
                    onTap: () {
//                context.pushNamed("/user-details", arguments: user);
                    }),
              ),
              menuContent: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Text(
                      "Dodaj do grupy",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Baloo'),
                    ),
                    trailing: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 15,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Text(
                      "Usuń ze znajomych",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Baloo'),
                    ),
                    trailing: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 15,
                    ),
                  )
                ],
              ),
            ),
            Text(
              "${user.name}",
              style: TextStyle(
                  color: color,
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
                              child: ListTile(
                                onTap: () {},
                                leading: Text(
                                  "Stwórz grupę",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Baloo'),
                                ),
                                trailing: Icon(
                                  Icons.create,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 15,
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                onTap: () {},
                                leading: Text(
                                  "Zaproszenia",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Baloo'),
                                ),
                                trailing: Icon(
                                  Icons.people_outline,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 15,
                                ),
                              ),
                            ),
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
                children: <Widget>[
                  _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                  // _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                  // _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                  // _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                  // _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                  // _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                ],
              ))
        ],
      ),
    );
  }
}
