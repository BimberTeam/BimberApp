import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/splash/splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData, 
      routes: {
        "/": (context) => SplashScreen(),
      },
      initialRoute: "/",
    );
  }
}
