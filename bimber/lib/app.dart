import 'package:bimber/bloc/auth/authentication.dart';
import 'package:bimber/resources/account_repository.dart';
import 'package:bimber/ui/home/home_screen.dart';
import 'package:bimber/ui/login/login_screen.dart';
import 'package:bimber/ui/login/starting_screen.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AccountRepository>(
            create: (context) => MockAccountRepository(),
          )
        ],
        child: BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(
              accountRepository: context.repository<AccountRepository>())
            ..add(AppStarted()),
          child: MaterialApp(
            title: "Bimber",
            theme: themeData,
            routes: {
              "/initial": (context) => StartingScreen(),
              "/login": (context) => LoginScreen(),
              "/home": (context) => HomeScreen()
            },
            initialRoute: "/initial",
          ),
        ));
  }
}
