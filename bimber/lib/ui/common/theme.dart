import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

const indigoDye = Color(0xFF0D3B66);
const lemonMeringue = Color(0xFFFAF0CA);
const orangeYellowCrayola = Color(0xFFF4D35E);
const sandyBrown = Color(0xFFEE964B);
const orangeSoda = Color(0xFFF95738);

final colorScheme = ColorScheme(
    primary: lemonMeringue,
    primaryVariant: TinyColor(lemonMeringue).darken(10).color,
    secondary: indigoDye,
    secondaryVariant: TinyColor(indigoDye).darken(10).color,
    surface: orangeYellowCrayola,
    background: sandyBrown, // changed
    error: Colors.red,
    onPrimary: sandyBrown,
    onSecondary: orangeYellowCrayola,
    onSurface: orangeYellowCrayola,
    onBackground: sandyBrown,
    onError: Colors.white,
    brightness: Brightness.dark);

final textTheme = TextTheme(
  headline1:
      TextStyle(color: Colors.white, fontSize: 96, fontWeight: FontWeight.w300),
  headline2:
      TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.w300),
  headline3:
      TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w400),
  headline4:
      TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w400),
  headline5:
      TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
  headline6:
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
  subtitle1:
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
  subtitle2:
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
  bodyText1:
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
  bodyText2:
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
  button:
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
  caption:
      TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
  overline:
      TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
);

final buttonTheme = ButtonTheme(textTheme: ButtonTextTheme.normal);

final themeData = ThemeData(
    textTheme: textTheme,
    colorScheme: colorScheme,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.standard,
    primaryColor: indigoDye,
    primaryColorBrightness: Brightness.dark,
    primaryColorLight: indigoDye,
    primaryColorDark: indigoDye,
    canvasColor: orangeYellowCrayola,
    accentColor: sandyBrown,
    accentColorBrightness: Brightness.light,
    scaffoldBackgroundColor: lemonMeringue,
    bottomAppBarColor: orangeYellowCrayola,
    cardColor: sandyBrown,
    dividerColor: Colors.black,
    focusColor: orangeYellowCrayola,
    hoverColor: orangeYellowCrayola,
    highlightColor: sandyBrown,
    splashColor: TinyColor(lemonMeringue).lighten().color,
    selectedRowColor: sandyBrown,
    disabledColor: TinyColor(orangeYellowCrayola).darken().color,
    unselectedWidgetColor: sandyBrown.withOpacity(0.7),
    buttonColor: indigoDye,
    textSelectionColor: orangeYellowCrayola.withOpacity(0.5),
    backgroundColor: lemonMeringue,
    dialogBackgroundColor: lemonMeringue,
    textSelectionHandleColor: indigoDye,
    hintColor: TinyColor(orangeYellowCrayola).darken(30).color,
    errorColor: Colors.red,
    toggleableActiveColor: orangeYellowCrayola);
