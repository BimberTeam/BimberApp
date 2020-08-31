import 'package:bimber/ui/common/utils.dart';
import 'package:bimber/ui/discover/discover_stack.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = sizeWithoutAppBar(context);
    final stackSize = size * 0.9;
    final footerSize = size * 0.1;
    return Column(
      children: <Widget>[
        Container(
            height: stackSize.height, child: DiscoverStack(size: stackSize)),
        Container(
          height: footerSize.height,
          padding: EdgeInsets.only(bottom: 5),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              createButton(context, Icons.clear, Colors.red, () => {}),
              createButton(context, Icons.check, Colors.green, () => {})
            ],
          ),
        )
      ],
    );
  }

  Container createButton(
      BuildContext context, IconData icon, Color iconColor, Function onTap) {
    return Container(
      height: 50.0,
      width: 50.0,
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