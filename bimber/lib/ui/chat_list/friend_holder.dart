import 'package:bimber/ui/chat_list/friend_holder_menu.dart';
import 'package:flutter/material.dart';
import 'package:build_context/build_context.dart';

class FriendHolder extends StatefulWidget {
  final Widget child, menuContent;

  const FriendHolder(
      {Key key, @required this.child, @required this.menuContent});

  @override
  _FriendHolderState createState() => _FriendHolderState();
}

class _FriendHolderState extends State<FriendHolder> {
  GlobalKey containerKey = GlobalKey();
  Offset childOffset = Offset(0, 0);
  Size childSize;

  getOffset() {
    RenderBox renderBox = containerKey.currentContext.findRenderObject();
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      this.childOffset = Offset(offset.dx, offset.dy);
      childSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: containerKey,
        onLongPress: () async {
          getOffset();
          context.pushNamed("/friend-menu",
              arguments: FriendMenuArguments(
                  child: widget.child,
                  childOffset: childOffset,
                  childSize: childSize,
                  menuContent: widget.menuContent));
        },
        child: widget.child);
  }
}
