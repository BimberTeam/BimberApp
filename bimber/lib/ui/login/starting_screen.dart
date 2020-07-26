import 'package:bimber/bloc/auth/authentication_bloc.dart';
import 'package:bimber/ui/login/login_screen.dart';
import 'package:bimber/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacementNamed("/home");
        }
      },
      builder: (context, state) {
        if (state is Unauthenticated) {
          return LoginScreen();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
