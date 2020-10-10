import 'dart:io';

import 'package:bimber/bloc/register/register_bloc.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/ui/common/account_form_fields.dart';
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
    final finalData = data?.copyWith(
        imagePath: ((values["imageUrl"] as List).first as File).path);
    context.bloc<RegisterBloc>().add(RegisterAccount(data: finalData));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        final data = state.data;

        return RegisterScaffold(
            title: Text("Rejestracja (3/3)"),
            child: ListView(
              children: <Widget>[
                FormBuilder(
                    key: _fbKey,
                    child: Column(
                      children: <Widget>[
                        Text("Dodaj zdjęcie profilowe",
                            style: textTheme.headline5
                                .copyWith(fontWeight: FontWeight.w600)),
                        AccountFormField.imagePicker(size),
                        SizedBox(
                            width: double.infinity,
                            child: ThemedPrimaryButton(
                              label: "Zarejestruj",
                              onPressed: () {
                                if (_fbKey.currentState.saveAndValidate()) {
                                  _confirm(
                                      context, data, _fbKey.currentState.value);
                                }
                              },
                            ))
                      ],
                    ))
              ],
            ));
      },
    );
  }
}
