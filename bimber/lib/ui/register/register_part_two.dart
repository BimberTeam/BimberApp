import 'package:bimber/bloc/register/register_bloc.dart';
import 'package:bimber/models/age_preference.dart';
import 'package:bimber/models/alcohol.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/ui/common/account_form_fields.dart';
import 'package:bimber/ui/common/age_preference_slider.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:bimber/ui/register/register_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:build_context/build_context.dart';

typedef AlcoholTypeValidator = String Function(dynamic);

class RegisterPartTwo extends StatefulWidget {
  State<RegisterPartTwo> createState() => _RegisterPartTwoState();
}

class _RegisterPartTwoState extends State<RegisterPartTwo> {
  final _fbKey = GlobalKey<FormBuilderState>();

  AgePreference _agePreference = AgePreference(from: 18, to: 99);

  final encouragement = """
  Przedstaw się! 
  """;
  final placeholder = """
  Dobry opis zwiększa twoją szansę na znalezienie bratnich dusz do picia! 
  Nie zapominaj, niestosowny opis grozi banem.
  """;

  // TODO: add favorite drink type (not preference), for now it's null
  _continue(BuildContext context, RegisterAccountData data,
      Map<String, dynamic> values) {
    var newData = data.copyWith(
        description: values["description"],
        genderPreference: values["genderPreference"],
        alcoholPreference: values["alcoholPreference"],
        favoriteAlcohol: Alcohol(name: values["alcoholName"], type: null),
        agePreference: _agePreference);

    context.bloc<RegisterBloc>().add(RegisterSaveData(data: newData));
    context.pushNamed("/three");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        final data = state.data;

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus.unfocus(),
          child: RegisterScaffold(
              title: Text("Rejestracja (2/3)",
                  style: textTheme.headline6
                      .copyWith(fontWeight: FontWeight.w700)),
              child: ListView(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    initialValue: {
                      "description": data?.description,
                      "genderPreference": data?.genderPreference,
                      "alcoholPreference": data?.alcoholPreference,
                      "alcoholName": data?.favoriteAlcohol?.name,
                    },
                    child: Column(
                      children: <Widget>[
                        AccountFormField.descriptionField,
                        SizedBox(height: 15),
                        AgePreferenceSlider(
                            preference: _agePreference,
                            onChanged: (range) {
                              setState(() {
                                _agePreference = AgePreference(
                                    from: range.start.toInt(),
                                    to: range.end.toInt());
                              });
                            }),
                        AccountFormField.genderPreferenceField,
                        AccountFormField.alcoholPreferenceField,
                        AccountFormField.alcoholNameField,
                        SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: ThemedPrimaryButton(
                            label: "Dalej",
                            onPressed: () {
                              if (_fbKey.currentState.saveAndValidate()) {
                                _continue(
                                    context, data, _fbKey.currentState.value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
