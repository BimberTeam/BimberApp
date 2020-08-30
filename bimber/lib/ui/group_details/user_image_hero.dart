import 'package:bimber/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImageHero extends StatelessWidget{
  final User user;
  final double height;
  final double width;
  final Function onTap;
  UserImageHero({
    @required this.user,
    @required this.height,
    @required this.width,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return  Hero(
      tag: user.id,
      createRectTween: (Rect begin, Rect end) {
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
              child: SizedBox(
                height: height,
                width: width,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: onTap,
                      child: CachedNetworkImage(
                          imageUrl: user.imageUrl,
                          imageBuilder: (context, image) {
                            return FittedBox(
                              fit: BoxFit.cover,
                              child: Image(image: image),
                            );
                          },
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              FittedBox(
                                fit: BoxFit.contain,
                                child: CircularProgressIndicator(value: downloadProgress.progress, strokeWidth: 1,),
                              ),
                          errorWidget: (context, url, error) =>
                              FittedBox(
                                fit: BoxFit.cover,
                                child:Icon(Icons.error, color: Colors.red),
                              )
                        )
                  )
                )
              )
    );
  }

}