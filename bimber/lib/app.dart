import 'package:bimber/bloc/auth/authentication_bloc.dart';
import 'package:bimber/resources/account_repository.dart';
import 'package:bimber/ui/discover/discover_screen.dart';
import 'package:bimber/ui/home/home_screen.dart';
import 'package:bimber/ui/login/login_screen.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/login/starting_screen.dart';
import 'package:bimber/ui/register/register_screen.dart';
import 'package:bimber/ui/splash/splash_screen.dart';
import 'package:bimber/ui/user_details/user_details.dart';
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
                        type: PageTransitionType.fade, child: StartingScreen());
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
                        settings: settings,
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 200),
                        child: RegisterScreen());
                  }
                case "/home":
                  {
                    return PageTransition(
                        type: PageTransitionType.downToUp, child: HomeScreen());
                  }
                case "/discover":
                  {
                    return PageTransition(
                        type: PageTransitionType.scale,
                        child: DiscoverScreen());
                  }
                case "/user-details":
                  {
                    return PageTransition(
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 700),
                        child: UserDetails(user: settings.arguments));
                  }
                default:
                  {
                    // this should not happen
                    assert(false);
                    return null;
                  }
              }
            },
            initialRoute: "/home",
          ),
        ));
  }
}
