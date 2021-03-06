import 'package:bimber/models/user.dart';
import 'package:bimber/ui/group_details/user_image_hero.dart';
import 'package:flutter/material.dart';

class DetailsAppBar extends StatelessWidget {
  final double appBarHeight;
  final User user;

  DetailsAppBar({@required this.appBarHeight, @required this.user});

  _backgroundImage(double width) {
    return UserImageHero(
      user: user,
      size: Size(width, appBarHeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: appBarHeight,
      pinned: true,
      floating: false,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
          background: _backgroundImage(MediaQuery.of(context).size.width)),
    );
  }
}
