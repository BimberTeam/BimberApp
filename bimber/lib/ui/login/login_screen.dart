import 'package:bimber/bloc/auth/authentication_bloc.dart';
import 'package:bimber/bloc/login/login_bloc.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
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
        create: (BuildContext context) => LoginBloc(
            accountRepository: context.repository<AccountRepository>()),
        child: Scaffold(
            body: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  context.hideCurrentSnackBar();
                  if (state is LoginEmailExists) {
                    _controller.forward();
                  } else if (state is LoginEmailNotExists) {
                    context.pushNamed("/register",
                        arguments: {"email": state.email});
                  } else if (state is LoginFailed) {
                    showErrorSnackbar(context, message: state.message);
                  } else if (state is LoginSucceed) {
                    context.bloc<AuthenticationBloc>().add(LoggedIn());
                  } else if (state is LoginLoading) {
                    showLoadingSnackbar(context,
                        message: "Poszukiwanie danych bimbrownika...");
                  } else if (state is LoginInitial) {
                    _controller.reset();
                  } else if (state is LoginServerNotResponding) {
                    showErrorSnackbar(context,
                        message: "Serwer nie odpowiada!");
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
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: LoginForm(controller: _controller)))))));
  }
}
