import 'package:bimber/app.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

final indigoDye = Color(0xFF0D3B66);
final lemonMeringue = Color(0xFFFAF0CA);
final orangeYellowCrayola = Color(0xFFF4D35E);
final sandyBrown = Color(0xFFEE964B);
final orangeSoda = Color(0xFFF95738);

final colorScheme = ColorScheme(
  primary: lemonMeringue,
  primaryVariant: TinyColor(lemonMeringue).darken(10).color,
  secondary: indigoDye,
  secondaryVariant: TinyColor(indigoDye).darken(10).color,
  surface: orangeYellowCrayola,
  background: lemonMeringue,
  error: Colors.red,
  onPrimary: sandyBrown,
  onSecondary: orangeYellowCrayola,
  onSurface: orangeSoda,
  onBackground: sandyBrown,
  onError: Colors.white,
  brightness: Brightness.light
);

final themeData = ThemeData(
  colorScheme: colorScheme,
  brightness: Brightness.light,
  visualDensity: VisualDensity.standard,
  primaryColor: indigoDye,
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: indigoDye,
  primaryColorDark: indigoDye,
  canvasColor: lemonMeringue,
  accentColor: sandyBrown,
  accentColorBrightness: Brightness.light,
  scaffoldBackgroundColor: lemonMeringue,
  bottomAppBarColor: orangeYellowCrayola,
  cardColor: lemonMeringue,
  dividerColor: orangeSoda,
  focusColor: orangeYellowCrayola,
  hoverColor: orangeYellowCrayola,
  highlightColor: sandyBrown,
  splashColor: orangeSoda,
  selectedRowColor: sandyBrown,
  disabledColor: orangeSoda.withOpacity(0.7),
  unselectedWidgetColor: sandyBrown.withOpacity(0.7),
  buttonColor: indigoDye,
  textSelectionColor: orangeYellowCrayola.withOpacity(0.5),
  // here a change
  backgroundColor: lemonMeringue,
  
  dialogBackgroundColor: lemonMeringue,
  textSelectionHandleColor: indigoDye,
  hintColor: orangeYellowCrayola.withOpacity(0.5),
  errorColor: Colors.red,
  toggleableActiveColor: orangeSoda,
  // TODO: add text themes
);
