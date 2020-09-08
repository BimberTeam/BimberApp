import 'package:bimber/models/user.dart';
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
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: UserImageHero(
                  user: user,
                  width: size,
                  height: size,
                  onTap: () {
//                context.pushNamed("/user-details", arguments: user);
                  }),
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
                      color: Theme.of(context).colorScheme.secondary,
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Text('Pokaż wszystkich'),
                            ),
                            PopupMenuItem(
                              child: Text('Zaproszenia'),
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
                  _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                  _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                  _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                  _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                  _memberAvatar(context, Fixtures.getUser(), Colors.white, 60),
                ],
              ))
        ],
      ),
    );
  }
}
