import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bimber/ui/common/utils.dart';

class DiscoverCard extends StatelessWidget {
  final Size size;
  final Widget child;

  DiscoverCard({@required this.size, @required this.child});

  Widget copy() {
    return DiscoverCard(child: child, size: size);
  }

  @override
  Widget build(BuildContext context) {
    var opacitiesNotifier = context.watchOrNull<SwipeCardLabelOpacities>();

    // necessary for updating card that is being used inside DiscoverSwipe
    if (opacitiesNotifier != null) {
      return Consumer<SwipeCardLabelOpacities>(
          child: child,
          builder: (context, value, child) {
            return _body(
                child: child,
                likeOpacity: value.likeOpacity,
                dislikeOpacity: value.dislikeOpacity);
          });
    }
    return _body(child: child, likeOpacity: 0, dislikeOpacity: 0);
  }

  _body({double likeOpacity, double dislikeOpacity, Widget child}) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        height: size.height,
        width: size.height,
        child: Stack(
          children: <Widget>[
            child,
            Positioned(
                top: 10,
                left: 10,
                child: SwipeCardLabel(
                    label: "LIKE", color: Colors.green, opacity: likeOpacity)),
            Positioned(
                top: 10,
                right: 10,
                child: SwipeCardLabel(
                    label: "NOPE", color: Colors.red, opacity: dislikeOpacity))
          ],
        ));
  }
}

class SwipeCardLabel extends StatelessWidget {
  final String label;
  final Color color;
  final double opacity;

  SwipeCardLabel({this.label, this.color, this.opacity});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Opacity(
        opacity: opacity,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 5, color: color),
            ),
            child: Text(label,
                style: TextStyle(
                    color: color, fontSize: 40, fontWeight: FontWeight.w700))),
      ),
    );
  }
}

class SwipeCardLabelOpacities extends ChangeNotifier {
  double likeOpacity;
  double dislikeOpacity;

  SwipeCardLabelOpacities({this.likeOpacity, this.dislikeOpacity});

  void setOpacities({double likeOpacity, double dislikeOpacity}) {
    this.likeOpacity = likeOpacity;
    this.dislikeOpacity = dislikeOpacity;
    notifyListeners();
  }
}
