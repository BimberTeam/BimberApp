import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class FriendMenuArguments {
  final Offset childOffset;
  final Size childSize;
  final Widget menuContent;
  final Widget child;

  const FriendMenuArguments({
    @required this.menuContent,
    @required this.childOffset,
    @required this.childSize,
    @required this.child,
  });
}

class FriendMenu extends StatelessWidget {
  final Offset childOffset;
  final Size childSize;
  final Widget menuContent;
  final Widget child;

  const FriendMenu({
    Key key,
    @required this.menuContent,
    @required this.childOffset,
    @required this.childSize,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final maxMenuWidth = size.width * 0.5;
    final maxMenuHeight = size.height * 0.35;
    final leftOffset = (childOffset.dx + maxMenuWidth) < size.width
        ? childOffset.dx
        : (childOffset.dx - maxMenuWidth + childSize.width);
    final topOffset =
        (childOffset.dy + maxMenuHeight + childSize.height) < size.height
            ? childOffset.dy + childSize.height
            : childOffset.dy - maxMenuHeight;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                 context.pop();
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                  ),
                )),
            Positioned(
              top: topOffset,
              left: leftOffset,
              child: Container(
                width: maxMenuWidth,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          spreadRadius: 1)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: menuContent,
                ),
              ),
            ),
            Positioned(
                top: childOffset.dy,
                left: childOffset.dx,
                child: AbsorbPointer(
                    absorbing: true,
                    child: Container(
                        width: childSize.width,
                        height: childSize.height,
                        child: child))),
          ],
        ),
      ),
    );
  }
}
