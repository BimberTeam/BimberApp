import 'package:bimber/models/user.dart';
import 'package:bimber/resources/services/image_service.dart';
import 'package:bimber/ui/common/cache_image.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';

class UserImageHero extends StatelessWidget {
  final User user;
  final Size size;
  final Function onTap;
  final BorderRadius borderRadius;

  UserImageHero(
      {@required this.user,
      @required this.size,
      this.onTap,
      BorderRadius radius = const BorderRadius.all(Radius.circular(0))})
      : borderRadius = radius;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: user.id,
        createRectTween: (Rect begin, Rect end) {
          return MaterialRectArcTween(begin: begin, end: end);
        },
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          _UserImageHolder fromHolder =
              (fromHeroContext.widget as Hero).child as _UserImageHolder;
          _UserImageHolder toHolder =
              (toHeroContext.widget as Hero).child as _UserImageHolder;

          return AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                final currentRadius = BorderRadius.lerp(
                    fromHolder.destinationRadius,
                    toHolder.destinationRadius,
                    flightDirection == HeroFlightDirection.push
                        ? animation.value
                        : 1 - animation.value);

                return _UserImageHolder(
                    destinationRadius: toHolder.destinationRadius,
                    currentRadius: currentRadius,
                    user: user,
                    onTap: () {},
                    size: size);
              });
        },
        child: _UserImageHolder(
            destinationRadius: borderRadius,
            user: user,
            onTap: onTap,
            size: size));
  }
}

class _UserImageHolder extends StatelessWidget {
  final BorderRadius destinationRadius;
  final BorderRadius currentRadius;
  final User user;
  final Function onTap;
  final Size size;

  _UserImageHolder(
      {@required this.destinationRadius,
      this.currentRadius,
      @required this.user,
      @required this.onTap,
      @required this.size});

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
                stops: [0.7, 1.0]),
          ),
          height: size.height,
          width: size.width,
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: onTap,
                  child: CustomCachedImage(
                    imageUrl: ImageService.getImageUrl(user.id),
                  )))),
    );
  }
}
