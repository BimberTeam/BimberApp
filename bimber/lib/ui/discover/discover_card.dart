import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bimber/ui/common/utils.dart';

class DiscoverCard extends StatelessWidget {
  final Size size;
  final Color color;

  DiscoverCard({@required this.size, @required this.color});

  @override
  Widget build(BuildContext context) {
    var opacitiesNotifier = context.watchOrNull<SwipeCardLabelOpacities>();

    if (opacitiesNotifier != null) {
      return Consumer<SwipeCardLabelOpacities>(
          builder: (context, value, child) {
        return _body(value.likeOpacity, value.dislikeOpacity);
      });
    }
    return _body(0, 0);
  }

  _body(double likeOpacity, double dislikeOpacity) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        height: size.height,
        width: size.height,
        child: Stack(
          children: <Widget>[
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
