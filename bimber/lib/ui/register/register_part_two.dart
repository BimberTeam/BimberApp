import 'package:bimber/bloc/register/register_bloc.dart';
import 'package:bimber/models/age_preference.dart';
import 'package:bimber/models/alcohol.dart';
import 'package:bimber/models/alcohol_type.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:bimber/ui/common/themed_primary_button.dart';
import 'package:bimber/ui/register/register_part_three.dart';
import 'package:bimber/ui/register/register_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:bimber/ui/common/language_utils.dart';
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
                        FormBuilderTextField(
                          minLines: 3,
                          maxLines: 5,
                          attribute: "description",
                          maxLength: 300,
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: orangeSoda)),
                              labelText: "Opis",
                              hintText: placeholder),
                          validators: [
                            FormBuilderValidators.minLength(10,
                                errorText: "Na prawdę? Minimum 10 znaków!"),
                            FormBuilderValidators.maxLength(300,
                                errorText: "Wow, to trochę za dużo!")
                          ],
                        ),
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
                        FormBuilderDropdown<Gender>(
                          attribute: "genderPreference",
                          decoration: InputDecoration(
                              labelText: "Preferowana płeć",
                              icon: Icon(Icons.wc)),
                          hint: Text("Z kim chcesz balować?"),
                          items: Gender.values
                              .map((gender) => DropdownMenuItem<Gender>(
                                  value: gender,
                                  child: Text(gender.readable())))
                              .toList()
                                ..add(DropdownMenuItem<Gender>(
                                    value: null, child: Text("Ktokolwiek"))),
                        ),
                        FormBuilderDropdown<AlcoholType>(
                            attribute: "alcoholPreference",
                            decoration: InputDecoration(
                                labelText: "Ulubiony rodzaj alkoholu",
                                icon: Icon(Icons.local_bar)),
                            hint: Text("Wybierz rozsądnie"),
                            items: AlcoholType.values
                                .map((type) => DropdownMenuItem<AlcoholType>(
                                    value: type, child: Text(type.readable())))
                                .toList(),
                            validators: <AlcoholTypeValidator>[
                              FormBuilderValidators.required(
                                  errorText: "Nic nie pijesz?")
                            ]),
                        FormBuilderTextField(
                          attribute: "alcoholName",
                          maxLines: 1,
                          decoration: InputDecoration(
                              hintText: "Twój ulubiony trunek",
                              labelText: "Napój Bogów",
                              icon: Icon(Icons.local_bar)),
                          validators: [
                            FormBuilderValidators.required(
                                errorText: "Pochawl się!"),
                            FormBuilderValidators.minLength(3,
                                errorText: "Czy coś takiego w ogóle istnieje?"),
                            FormBuilderValidators.maxLength(30,
                                errorText: "Komu chce się to czyta��?"),
                          ],
                        ),
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
