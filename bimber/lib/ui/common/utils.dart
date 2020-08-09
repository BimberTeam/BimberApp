import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

Size sizeWithoutAppBar(BuildContext context) {
  // final height = MediaQuery.of(context).size.height — MediaQuery.of(context).padding.top — kToolbarHeight;
  final height = MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      kToolbarHeight;
  final width = MediaQuery.of(context).size.width;
  return Size(width, height);
}

double radians(double degree) {
  return degree * math.pi / 180.0;
}

double rangeProgress(double from, double to, double val) {
  assert(from < to);
  if (val < from) return 0;
  if (val > to) return 1;

  final fromAbs = from.abs();
  from += fromAbs;
  to += fromAbs;
  val += fromAbs;

  return val / (from + to);
}

double interpolate(double value,
    {double inputFrom, double inputTo, double outputFrom, double outputTo}) {
  final progress = rangeProgress(inputFrom, inputTo, value);
  return lerpDouble(outputFrom, outputTo, progress);
}

Color randomColor() {
  var random = new math.Random();
  return Color.fromARGB(
      255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
}

extension WachOrNull on BuildContext {
  T watchOrNull<T>() {
    try {
      return watch<T>();
    } on ProviderNotFoundException catch (err) {
      return null;
    }
  }
}
