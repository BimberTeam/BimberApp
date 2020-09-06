import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/cache_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/painting.dart';

class GroupImageHero extends StatelessWidget {
  final Group group;
  final double height;
  final double width;

  GroupImageHero({
    @required this.group,
    @required this.height,
    @required this.width,
  });

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = sqrt(group.members.length).ceil();
    return Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Hero(
            tag: group.id,
            createRectTween: (Rect begin, Rect end) {
              return MaterialRectCenterArcTween(begin: begin, end: end);
            },
            child: SizedBox(
                height: height,
                width: width,
                child: GridView.count(
                    padding: EdgeInsets.all(0),
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: (width / height),
                    children: group.members.map((User member) {
                      final url = member.imageUrl;
                      return GridTile(
                          child: CustomCachedImage(
                        imageUrl: url,
                      ));
                    }).toList()))));
  }
}
