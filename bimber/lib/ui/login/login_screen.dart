import 'package:bimber/bloc/login/login.dart';
import 'package:bimber/resources/account_repository.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:build_context/build_context.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (BuildContext context) =>
            LoginBloc(context.repository<AccountRepository>()),
        child: Scaffold(
            body: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  context.hideCurrentSnackBar();
                  if (state is LoginEmailExists) {
                    _controller.forward();
                  } else if (state is LoginFailed) {
                    showErrorSnackbar(context, message: "Nieprawidłowe hasło");
                  } else if (state is LoginSucceed) {
                    Navigator.of(context).pushReplacementNamed("/home");
                  } else if (state is LoginLoading) {
                    showLoadingSnackbar(context,
                        message: "Poszukiwanie danych bimbrownika...");
                  } else if (state is LoginEmailNotExists) {
                    context.pushNamed("/register");
                  } else if (state is LoginInitial) {
                    _controller.reset();
                  } else {
                    context.pushNamed("/splash");
                  }
                },
                child: SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [orangeYellowCrayola, sandyBrown],
                            tileMode: TileMode
                                .repeated, // repeats the gradient over the canvas
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: LoginForm(controller: _controller)))))));
  }
}