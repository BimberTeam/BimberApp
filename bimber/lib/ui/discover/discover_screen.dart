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
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                createButton(context, Icons.clear, Colors.red, () => {}),
                createButton(context, Icons.check, Colors.green, () => {})
              ],
            ),
          ),
        )
      ],
    );
  }

  Container createButton(
      BuildContext context, IconData icon, Color iconColor, Function onTap) {
    return Container(
      child: ClipOval(
        child: Material(
          color: Theme.of(context).colorScheme.primaryVariant,
          child: InkWell(
            splashColor: Theme.of(context).accentColor, // inkwell color
            child: Icon(icon, color: iconColor, size: 50),
            onTap: onTap,
          ),
        ),
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
