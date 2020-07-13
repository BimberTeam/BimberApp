import 'package:bimber/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/splash/splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, accentColor: Colors.black),
      routes: {
        "/": (context) => SplashScreen(),
        "/login": (context) => LoginScreen()
      },
      initialRoute: "/login",
    );
  }
}
