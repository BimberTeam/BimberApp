import 'package:bimber/bloc/register/register_bloc.dart';
import 'package:bimber/resources/mocks/mock_account_repository.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/register/register_part_one.dart';
import 'package:bimber/ui/register/register_part_three.dart';
import 'package:bimber/ui/register/register_part_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:build_context/build_context.dart';

class RegisterScreen extends StatelessWidget {
  String _navigationArumentEmail(BuildContext context) {
    return (ModalRoute.of(context).settings.arguments
        as Map<String, String>)["email"];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
        create: (context) =>
            RegisterBloc(repository: context.repository<AccountRepository>()),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (_context, state) {
            if (state is RegisterNavigateToLogin) {
              context.pop();
            }
          },
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
          ),
        ));
  }
}
