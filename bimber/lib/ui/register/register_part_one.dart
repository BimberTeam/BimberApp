import 'package:bimber/bloc/register/register_bloc.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:bimber/ui/register/register_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:bimber/ui/common/language_utils.dart';
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
                    FormBuilderTextField(
                      maxLines: 1,
                      attribute: "email",
                      decoration: InputDecoration(
                          labelText: "Email", icon: Icon(Icons.email)),
                      validators: [
                        FormBuilderValidators.email(
                            errorText: "Nieprawidłowy format email"),
                      ],
                    ),
                    SizedBox(height: 15),
                    FormBuilderTextField(
                      attribute: "name",
                      maxLines: 1,
                      decoration: InputDecoration(
                          labelText: "Nazwa",
                          hintText: "Nazwa pod jaką cię widać",
                          icon: Icon(Icons.person_outline)),
                      validators: [
                        FormBuilderValidators.pattern("[a-zA-Z ]",
                            errorText:
                                "Twoja nazwa może skłądać się tylko z liter"),
                        FormBuilderValidators.minLength(3,
                            errorText:
                                "Prawdzia osoba zaczyna się od 3 znaków"),
                        FormBuilderValidators.maxLength(15,
                            errorText: "Myślisz, że komuś chce się to czytać?"),
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: "password",
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Hasło",
                          hintText: "Wybierz dobrze",
                          icon: Icon(Icons.lock_outline)),
                      validators: [
                        FormBuilderValidators.minLength(6,
                            errorText: "Użyj conajmniej 6 znaków"),
                        FormBuilderValidators.maxLength(30,
                            errorText: "Na pewno zapamiętasz tyle znkaów?"),
                      ],
                    ),
                    SizedBox(height: 15),
                    FormBuilderTextField(
                      attribute: "confirmPassword",
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Powtórz hasło",
                          hintText: "Musi być takie samo",
                          icon: Icon(Icons.lock_outline)),
                      validators: [
                        (value) {
                          if (value !=
                              _fbKey.currentState.fields['password']
                                  .currentState.value) {
                            return "Hasła się nie zgadzają";
                          }
                          return null;
                        }
                      ],
                    ),
                    SizedBox(height: 15),
                    FormBuilderDropdown<Gender>(
                        attribute: "gender",
                        decoration: InputDecoration(
                            labelText: "Płeć", icon: Icon(Icons.wc)),
                        hint: Text('Określ swoją płeć'),
                        items: Gender.values
                            .map((gender) => DropdownMenuItem<Gender>(
                                value: gender, child: Text(gender.readable())))
                            .toList(),
                        validators: <GenderValidator>[
                          FormBuilderValidators.required(
                              errorText: "Podaj płeć")
                        ]),
                    SizedBox(height: 15),
                    FormBuilderTextField(
                      attribute: "age",
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      decoration: InputDecoration(
                          labelText: "Wiek", icon: Icon(Icons.calendar_today)),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: "Zapomniałeś o czymś?"),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.min(18,
                            errorText: "Musisz być pełnoletni!"),
                        FormBuilderValidators.max(99,
                            errorText:
                                "Przy takim wieku może lepiej zostać w domu?"),
                      ],
                    ),
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
