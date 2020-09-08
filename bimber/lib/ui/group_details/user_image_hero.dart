import 'package:bimber/models/user.dart';
import 'package:bimber/ui/common/cache_image.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';

class UserImageHero extends StatelessWidget {
  final User user;
  final double height;
  final double width;
  final Function onTap;

  UserImageHero(
      {@required this.user,
      @required this.height,
      @required this.width,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: user.id,
        createRectTween: (Rect begin, Rect end) {
          return MaterialRectCenterArcTween(begin: begin, end: end);
        },
        child: Container(
            color: indigoDye,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                  tileMode: TileMode.clamp,
                  stops: [0.7, 1.0]),
            ),
            height: height,
            width: width,
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: onTap,
                    child: CustomCachedImage(
                      imageUrl: user.imageUrl,
                    )))));
  }
}
