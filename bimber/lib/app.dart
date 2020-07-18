import 'package:bimber/bloc/auth/authentication.dart';
import 'package:bimber/resources/account_repository.dart';
import 'package:bimber/ui/home/home_screen.dart';
import 'package:bimber/ui/login/login_screen.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/register/register_screen.dart';
import 'package:bimber/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

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
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case "/":
                  {
                    return PageTransition(
                        type: PageTransitionType.fade, child: LoginScreen());
                  }
                case "/splash":
                  {
                    return PageTransition(
                        type: PageTransitionType.fade, child: SplashScreen());
                  }
                case "/login":
                  {
                    return PageTransition(
                        type: PageTransitionType.downToUp,
                        child: LoginScreen());
                  }
                case "/register":
                  {
                    return PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        child: RegisterScreen());
                  }
                case "/home":
                  {
                    return PageTransition(
                        type: PageTransitionType.downToUp, child: HomeScreen());
                  }
                default:
                  {
                    // this should not happen
                    assert(false);
                    return null;
                  }
              }
            },
            initialRoute: "/",
          ),
        ));
  }
}
