import 'package:bimber/models/group.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bimber/ui/group_details/group_image_hero.dart';
import 'package:flutter/material.dart';

class GroupDetailsAppBar extends StatelessWidget {
  final double appBarHeight;
  final Group group;

  GroupDetailsAppBar({@required this.appBarHeight, @required this.group});

  @override
  Widget build(BuildContext context) {
    double silverPadding = 0.0375 * MediaQuery.of(context).size.height;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: appBarHeight,
      pinned: true,
      floating: false,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
          background: GroupImageHero(
              group: group,
              size: Size(MediaQuery.of(context).size.width,
                  appBarHeight + silverPadding))),
    );
  }
}
