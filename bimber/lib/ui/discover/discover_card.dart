import 'package:flutter/material.dart';

class DiscoverCard extends StatelessWidget {
  final Size size;
  final Widget child;

  DiscoverCard({@required this.size, @required this.child});

  Widget copy() {
    return DiscoverCard(child: child, size: size);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      child: child,
    );
  }
}
