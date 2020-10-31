import 'package:bimber/models/group.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/services/image_service.dart';
import 'package:bimber/ui/common/cache_image.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/painting.dart';

class GroupImageHero extends StatelessWidget {
  final Group group;
  final Size size;
  final BorderRadius borderRadius;

  GroupImageHero(
      {@required this.group,
      @required this.size,
      BorderRadius radius = const BorderRadius.all(Radius.circular(0))})
      : borderRadius = radius;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: group.id,
        createRectTween: (Rect begin, Rect end) {
          return MaterialRectCenterArcTween(begin: begin, end: end);
        },
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          _GroupImageHolder fromHolder =
              (fromHeroContext.widget as Hero).child as _GroupImageHolder;
          _GroupImageHolder toHolder =
              (toHeroContext.widget as Hero).child as _GroupImageHolder;

          return AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              final currentRadius = BorderRadius.lerp(
                  fromHolder.destinationRadius,
                  toHolder.destinationRadius,
                  flightDirection == HeroFlightDirection.push
                      ? animation.value
                      : 1 - animation.value);
              return _GroupImageHolder(
                group: group,
                size: size,
                destinationRadius: toHolder.destinationRadius,
                currentRadius: currentRadius,
              );
            },
          );
        },
        child: _GroupImageHolder(
            group: group, size: size, destinationRadius: borderRadius));
  }
}

class _GroupImageHolder extends StatelessWidget {
  final Group group;
  final Size size;
  final BorderRadius destinationRadius;
  final BorderRadius currentRadius;
  final int crossAxisCount;

  _GroupImageHolder(
      {@required this.group,
      @required this.size,
      @required this.destinationRadius,
      this.currentRadius})
      : crossAxisCount = sqrt(group.members.length).ceil();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: currentRadius ?? destinationRadius,
      child: Container(
          color: indigoDye,
          foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                  tileMode: TileMode.clamp,
                  stops: [0.7, 1.0])),
          height: size.height,
          width: size.width,
          child: GridView.count(
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              childAspectRatio: (size.width / size.height),
              children: group.members.map((User member) {
                final url = ImageService.getRandomHarnasUrl(member.id);
                return GridTile(
                    child: CustomCachedImage(
                  imageUrl: url,
                ));
              }).toList())),
    );
  }
}
