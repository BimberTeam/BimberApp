import 'dart:io';

import 'package:bimber/bloc/register/register_bloc.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/ui/common/account_form_fields.dart';
import 'package:bimber/ui/common/snackbar_utils.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:bimber/ui/register/register_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterPartThree extends StatelessWidget {
  final _fbKey = GlobalKey<FormBuilderState>();

  _confirm(BuildContext context, RegisterAccountData data,
      Map<String, dynamic> values) {
    // FIXME: add favorite alcohol type field somewhere
    final finalData = data?.copyWith(
        favoriteAlcoholType: data.alcoholPreference,
        agePreferenceFrom: data.agePreference.from,
        agePreferenceTo: data.agePreference.to,
        imagePath: ((values["imageUrl"] as List).first as File).path);
    context.bloc<RegisterBloc>().add(RegisterAccount(data: finalData));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RegisterScaffold(
      title: Text("Rejestracja (3/3)"),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            showSuccessSnackbar(context, message: "Pomyślnie utworzono konto!");
          }
          if (state is RegisterError) {
            showErrorSnackbar(context, message: state.message);
          }
          if (state is RegisterServerNotResponding) {
            showErrorSnackbar(context, message: "Serwer nie odpowiada...");
          }
        },
        builder: (context, state) {
          final data = state.data;

          return ListView(
            children: <Widget>[
              FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: <Widget>[
                      AccountFormField.imagePicker(size),
                      SizedBox(
                          width: double.infinity,
                          child: Builder(
                            builder: (context) => ThemedPrimaryButton(
                              label: "Zarejestruj",
                              onPressed: () {
                                if (_fbKey.currentState.saveAndValidate()) {
                                  _confirm(
                                      context, data, _fbKey.currentState.value);
                                }
                              },
                            ),
                          ))
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }
}
