import 'package:bimber/bloc/auth/authentication.dart';
import 'package:bimber/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return BlocListener<AuthenticationBloc, AuthenticationState>(
    listener: (context, state) {
      if (state is Authenticated) {
        Navigator.of(context).pushReplacementNamed("/home");
      } else if(state is Unauthenticated){
        Navigator.of(context).pushReplacementNamed("/login");
      }
    },
    child: SplashScreen()
   );
  }

}