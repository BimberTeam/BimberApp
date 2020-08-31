import 'package:bimber/bloc/register/register_bloc.dart';
import 'package:bimber/models/age_preference.dart';
import 'package:bimber/models/alcohol.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/ui/common/account_form_fields.dart';
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
  var _agePreference;

  final encouragement = """
  Przedstaw się! 
  """;
  final placeholder = """
  Dobry opis zwiększa twoją szansę na znalezienie bratnich dusz do picia! 
  Nie zapominaj, niestosowny opis grozi banem.
  """;
  final agePreferenceText = "Preferencje wiekowe: ";

  _toAgePreferenceModel() {
    return AgePreference(
        from: _agePreference?.start?.toInt() ?? 18,
        to: _agePreference?.end?.toInt() ?? 99);
  }

  _fromAgePreferenceModel(RegisterAccountData data) {
    // only data is set
    if (data?.agePreference != null && _agePreference == null) {
      return RangeValues(
          data.agePreference.from.toDouble(), data.agePreference.to.toDouble());
    }

    // first load so return default
    if (data?.agePreference == null && _agePreference == null)
      return RangeValues(18, 99);

    return _agePreference;
  }

  // TODO: add favorite drink type (not preference), for now it's null
  _continue(BuildContext context, RegisterAccountData data,
      Map<String, dynamic> values) {
    var newData = data.copyWith(
        description: values["description"],
        genderPreference: values["genderPreference"],
        alcoholPreference: values["alcoholPreference"],
        favoriteAlcohol: Alcohol(name: values["alcoholName"], type: null),
        agePreference: _toAgePreferenceModel());

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
                        Text(
                            agePreferenceText +
                                "(${_agePreference?.start?.toInt() ?? 18} - ${_agePreference?.end?.toInt() ?? 99})",
                            style: textTheme.subtitle1),
                        RangeSlider(
                          values: _fromAgePreferenceModel(data),
                          labels: RangeLabels(
                              "Wiek od ${_agePreference?.start?.toInt() ?? 18}",
                              "Wiek do ${_agePreference?.end?.toInt() ?? 99}"),
                          min: 18,
                          max: 99,
                          divisions: 99 - 18,
                          onChanged: (value) {
                            setState(() {
                              _agePreference = value;
                            });
                          },
                        ),
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
