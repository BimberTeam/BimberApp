import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/cache_image.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bimber/ui/group_details/group_image_hero.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GroupDetailsAppBar extends StatelessWidget {
  final double appBarHeight;
  final Group group;

  GroupDetailsAppBar({@required this.appBarHeight, @required this.group});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: appBarHeight,
      pinned: true,
      floating: false,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: LayoutBuilder(
            builder: ((BuildContext context, BoxConstraints constraints) {
              if (constraints.biggest.height < (silverAppBarHeight + 5)) {
                return Text("Grupa");
              } else {
                return Container();
              }
            }),
          ),
          background: GroupImageHero(
              group: group,
              height: appBarHeight,
              width: MediaQuery.of(context).size.width)),
    );
  }
}
