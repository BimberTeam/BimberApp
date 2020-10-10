import 'package:bimber/models/age_preference.dart';
import 'package:bimber/ui/common/theme.dart';
import 'package:flutter/material.dart';

class AgePreferenceSlider extends StatelessWidget {
  final AgePreference preference;
  final Function onChanged;

  final agePreferenceText = "Preferencje wiekowe: ";

  AgePreferenceSlider({@required this.preference, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(agePreferenceText + "(${preference.from} - ${preference.to})",
          style: textTheme.subtitle1),
      RangeSlider(
        values:
            RangeValues(preference.from.toDouble(), preference.to.toDouble()),
        labels: RangeLabels(
            "Wiek od ${preference.from}", "Wiek do ${preference.to}"),
        min: 18,
        max: 99,
        divisions: 99 - 18,
        onChanged: onChanged,
      ),
    ]);
  }
}
