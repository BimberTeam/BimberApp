import 'package:bimber/ui/common/utils.dart';
import 'package:bimber/ui/discover/discover_stack.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = sizeWithoutAppBar(context);
    final stackSize = Size(size.width, size.height * 0.9);
    return Column(
      children: <Widget>[
        Container(
            height: stackSize.height, child: DiscoverStack(size: stackSize)),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                createButton(
                    context,
                    Icons.clear,
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondaryVariant,
                    () => {}),
                createButton(
                    context,
                    Icons.favorite_border,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                    () => {})
              ],
            ),
          ),
        )
      ],
    );
  }

  Container createButton(BuildContext context, IconData icon,
      Color backgroundColor, Color iconColor, Function onTap) {
    return Container(
      child: MaterialButton(
        color: backgroundColor,
        child: Icon(icon, color: iconColor, size: 50),
        onPressed: onTap,
        padding: EdgeInsets.all(5),
        shape: CircleBorder(),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              offset: Offset(3.0, 3.0),
              spreadRadius: 3.0)
        ],
      ),
    );
  }
}
