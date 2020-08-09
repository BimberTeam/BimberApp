import 'package:bimber/ui/common/utils.dart';
import 'package:bimber/ui/discover/discover_card.dart';
import 'package:bimber/ui/discover/discover_stack.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = sizeWithoutAppBar(context);
    final stackSize = size * 0.9;
    final footerSize = size * 0.1;
    return Scaffold(
        appBar: AppBar(title: Text("Testing appbar"), centerTitle: true),
        body: Column(
          children: <Widget>[
            Container(
                height: stackSize.height,
                child: DiscoverStack(size: stackSize)),
            Container(
              color: Colors.black,
              height: footerSize.height,
              width: double.infinity,
            )
          ],
        ));
  }
}
