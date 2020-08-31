import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/cache_image.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GroupDetailsAppBar extends StatelessWidget {
  final double appBarHeight;
  final List<User> members;

  GroupDetailsAppBar({@required this.appBarHeight, @required this.members});

  _backgroundImage(List<User> members, double height, double width) {
    List<String> imageUrls = members.map((e) => e.imageUrl).toList();
    int crossAxisCount = sqrt(imageUrls.length).ceil();
    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        childAspectRatio: (width / height),
        children: imageUrls.map((String url) {
          return GridTile(
              child: CustomCachedImage(
            imageUrl: url,
          ));
        }).toList());
  }

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
          background: _backgroundImage(
              members, appBarHeight, MediaQuery.of(context).size.width)),
    );
  }
}
