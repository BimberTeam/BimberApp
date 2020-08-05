import 'package:bimber/bloc/register/register_bloc.dart';
import 'package:bimber/resources/account_repository.dart';
import 'package:bimber/ui/register/register_part_one.dart';
import 'package:bimber/ui/register/register_part_three.dart';
import 'package:bimber/ui/register/register_part_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatelessWidget {
  String _navigationArumentEmail(BuildContext context) {
    print(ModalRoute.of(context).settings.arguments);
    return (ModalRoute.of(context).settings.arguments
        as Map<String, String>)["email"];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
        create: (context) =>
            RegisterBloc(repository: context.repository<AccountRepository>()),
        child: Navigator(
          initialRoute: "/one",
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case "/one":
                {
                  return PageTransition(
                      type: PageTransitionType.fade,
                      child: RegisterPartOne(
                          initalEmail: _navigationArumentEmail(context)));
                }
              case "/two":
                {
                  return PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: RegisterPartTwo());
                }
              case "/three":
                {
                  return PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: RegisterPartThree());
                }
              default:
                return null;
            }
          },
        ));
  }
}
