import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';

class DiscoverCardContent extends StatelessWidget {
  final Group group;
  final Size size;
  final User onlyUser;

  DiscoverCardContent({@required this.group, @required this.size})
      : onlyUser = group.members.length == 1 ? group.members.first : null;

  buildHero() {
    if(onlyUser != null){
      return UserImageHero(user: onlyUser, height: size.height, width: size.width, onTap: () {});
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Positioned(bottom: 0, child: buildHero()),
          Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(0),
                width: size.width,
                height: (size.height / 1.2) * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x00000000), Color(0xdd000000)],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Align(
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
                    )),
              ))
        ],
    );
  }
}
