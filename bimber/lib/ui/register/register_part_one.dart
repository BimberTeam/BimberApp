import 'package:bimber/bloc/register/register_bloc.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/ui/common/account_form_fields.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:bimber/ui/register/register_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:build_context/build_context.dart';

typedef GenderValidator = String Function(dynamic);

class RegisterPartOne extends StatelessWidget {
  final String initalEmail;
  final _fbKey = GlobalKey<FormBuilderState>();

  RegisterPartOne({@required this.initalEmail});

  _continue(BuildContext context, RegisterAccountData data,
      Map<String, dynamic> values) {
    values.update("age", (age) => int.parse(age));
    values.update("gender", (gender) => (gender as Gender).toJson());

    var newData = (data ?? RegisterAccountData.fromJson(values)).copyWith(
        email: values["email"],
        name: values["name"],
        password: values["password"],
        gender: GenderExtension.fromJson(values["gender"]),
        age: values["age"]);

    context.bloc<RegisterBloc>().add(RegisterSaveData(data: newData));
    context.pushNamed("/two");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      final data = state.data;

      return RegisterScaffold(
          title: Text("Rejestracja (1/3)"),
          child: ListView(children: <Widget>[
            FormBuilder(
                key: _fbKey,
                initialValue: {
                  'email': initalEmail,
                  'name': data?.name,
                  'password': data?.password,
                  'confirmPassword': data?.password,
                  'gender': data?.gender,
                  'age': data?.age
                },
                child: Column(
                  children: <Widget>[
                    AccountFormField.emailField,
                    SizedBox(height: 15),
                    AccountFormField.nameField,
                    AccountFormField.passwordField,
                    SizedBox(height: 15),
                    AccountFormField.confirmPassowrdField(_fbKey),
                    SizedBox(height: 15),
                    AccountFormField.genderField,
                    SizedBox(height: 15),
                    AccountFormField.ageField,
                    SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ThemedPrimaryButton(
                        label: "Dalej",
                        onPressed: () {
                          if (_fbKey.currentState.saveAndValidate()) {
                            _continue(context, data, _fbKey.currentState.value);
                          }
                        },
                      ),
                    ),
                  ],
                )),
          ]));
    });
  }
}
