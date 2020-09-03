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

  DiscoverCardContent({@required this.group, @required this.size})
      : onlyUser = group.members.length == 1 ? group.members.first : null;

  _hero() {
    if (onlyUser != null) {
      return UserImageHero(
          user: onlyUser, height: size.height, width: size.width, onTap: () {});
    }
    return GroupImageHero(
        group: this.group, width: size.width, height: size.height);
  }

  _navigateToDetails(BuildContext context) {
    print("dupa");
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      if(onlyUser != null){
//        context.pushNamed("/user-details", arguments: onlyUser);
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Stack(
          children: <Widget>[
            Positioned(bottom: 0, child: _hero()),
            Positioned(
                bottom: 0,
                child: Container(
                    padding: EdgeInsets.all(0),
                    width: size.width,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x00000000), Color(0xff000000)],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                  onlyUser != null
                                      ? onlyUser.name +
                                          ", " +
                                          onlyUser.age.toString()
                                      : "Grupa",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Baloo',
                                      color: Colors.white,
                                      decoration: TextDecoration.none)),
                            )),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Material(
//                            color: Colors.transparent,
                                child: InkWell(
                                    onTap: _navigateToDetails(context),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 20, bottom: 20),
                                      child: Icon(
                                        Icons.info,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ))))
                      ],
                    )))
          ],
        ));
  }
}
