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
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      height: size.height,
      width: size.height,
      child: child,
    );
  }
}
