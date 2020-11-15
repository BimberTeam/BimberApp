import 'package:bimber/bloc/auth/authentication_bloc.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  String animation = "pop";
  final FlareControls _controls = FlareControls();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthServerNotResponding) {
          setState(() {
            animation = "error";
          });
          _controls.play("error");
        }
      },
      child: Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [orangeYellowCrayola, sandyBrown],
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: FlareActor(
                      "assets/logo-animation.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: animation,
                      controller: _controls,
                    ),
                  ),
                  animation == "pop"
                      ? Text(
                          "Pora na lepszy Tinder",
                          style: TextStyle(
                              color: lemonMeringue,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Baloo'),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          "Serwer nie odpowiada...",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Baloo'),
                          textAlign: TextAlign.center,
                        )
                ],
              ))),
    );
  }
}
