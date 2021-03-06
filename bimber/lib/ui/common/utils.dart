import 'dart:ui';
import 'dart:math' as math;
import 'package:bimber/models/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

void calculateCurrentDistanceFrom(
    Location location, void Function(double) onGetDistance) async {
  try {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    double distanceInMeters = await Geolocator().distanceBetween(
        position.latitude,
        position.longitude,
        location.latitude,
        location.longitude);
    onGetDistance(distanceInMeters);
  } catch (e) {}
}

Color colorFromGroupId(String groupId) {
  return Color(groupId.hashCode).withOpacity(1.0);
}

Future<double> getRangePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double value = prefs.getDouble("range_preference");
  if (value != null)
    return value;
  else
    return 50;
}

Future<double> setRangePreference(double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble("range_preference", value);
}
