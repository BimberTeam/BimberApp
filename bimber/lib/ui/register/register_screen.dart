import 'package:bimber/bloc/register/register_bloc.dart';
import 'package:bimber/resources/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
        create: (context) =>
            RegisterBloc(repository: context.repository<AccountRepository>()),
        child: Scaffold(
          appBar: AppBar(centerTitle: true, title: Text("Rejestracja")),
          body: Center(child: Text("Rejestracja essa")),
        ));
  }
}
