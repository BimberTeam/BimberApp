import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/ui/group_details/group_image_hero.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class DiscoverCardContent extends StatelessWidget {
  final Group group;
  final Size size;
  final User onlyUser;
  final Widget hero;

  static const heroBorderRadius = const BorderRadius.all(Radius.circular(15));

  DiscoverCardContent({@required this.group, @required this.size})
      : onlyUser = group.members.length == 1 ? group.members.first : null,
        hero = group.members.length == 1
            ? UserImageHero(user: group.members.first, size: size)
            : GroupImageHero(
                group: group, size: size, radius: heroBorderRadius);

  _navigateToDetails(BuildContext context) {
    if (onlyUser != null) {
      context.pushNamed("/user-details", arguments: onlyUser);
    } else {
      context.pushNamed("/group-details", arguments: group);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (group.members.length == 0) return Container();
    return ClipRRect(
      borderRadius: heroBorderRadius,
      child: Stack(
        children: <Widget>[
          Positioned(bottom: 0, child: hero),
          Positioned(left: 0, bottom: 0, child: _name()),
          Positioned(right: 0, bottom: 0, child: _info(context)),
        ],
      ),
    );
  }

  _name() {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
              onlyUser != null
                  ? onlyUser.name + ", " + onlyUser.age.toString()
                  : "Grupa",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Baloo',
                  color: Colors.white,
                  decoration: TextDecoration.none)),
        ));
  }

  _info(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 30, bottom: 20),
            child: Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
          )),
    );
  }
}
