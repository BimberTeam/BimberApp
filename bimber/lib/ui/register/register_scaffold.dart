import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';

class RegisterScaffold extends StatelessWidget {
  final Widget title;
  final Widget child;

  RegisterScaffold({@required this.title, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: title,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: RadialGradient(
              radius: 1,
              colors: [orangeYellowCrayola, sandyBrown],
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            )),
            padding: EdgeInsets.only(top: 20, right: 30, left: 30),
            child: child));
  }
}
