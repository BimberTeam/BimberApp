import 'dart:ui';
import 'dart:math' as math;

import 'package:bimber/models/age_preference.dart';
import 'package:bimber/models/alcohol.dart';
import 'package:bimber/models/alcohol_type.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/location.dart';
import 'package:bimber/models/user.dart';
import 'package:flutter/material.dart';

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

Group getGroup(){
  return Group(id: null, averageAge: 20, averageLocation: Location(latitude: 50.44, longtitude: 56.78), members: [
    User(id: null,
      name: "Harnas",
      email: null,
      gender: Gender.Male,
      age: 18,
      description: "Harnas, piwo z gór",
      favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
      genderPreference: Gender.Male,
      agePreference: AgePreference(from: 18, to: 99),
      alcoholPreference: AlcoholType.Beer,
      imageUrl: "https://wygraland.pl/wp-content/uploads/2017/02/harnas-1.jpg",
      location: Location(latitude: 50.44, longtitude: 56.78),
      friends: null),
    User(id: null,
        name: "Harnas",
        email: null,
        gender: Gender.Male,
        age: 22,
        description: "Harnas, piwo z gór",
        favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
        genderPreference: Gender.Male,
        agePreference: AgePreference(from: 18, to: 99),
        alcoholPreference: AlcoholType.Beer,
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.png",
        location: Location(latitude: 50.44, longtitude: 56.78),
        friends: null),
    User(id: null,
        name: "Harnas",
        email: null,
        gender: Gender.Male,
        age: 22,
        description: "Harnas, piwo z gór",
        favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
        genderPreference: Gender.Male,
        agePreference: AgePreference(from: 18, to: 99),
        alcoholPreference: AlcoholType.Beer,
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.pg",
        location: Location(latitude: 50.44, longtitude: 56.78),
        friends: null),
    User(id: null,
        name: "Harnas",
        email: null,
        gender: Gender.Male,
        age: 22,
        description: "Harnas, piwo z gór",
        favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
        genderPreference: Gender.Male,
        agePreference: AgePreference(from: 18, to: 99),
        alcoholPreference: AlcoholType.Beer,
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
        location: Location(latitude: 50.44, longtitude: 56.78),
        friends: null),
    User(id: null,
        name: "Harnas",
        email: null,
        gender: Gender.Male,
        age: 22,
        description: "Harnas, piwo z gór",
        favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
        genderPreference: Gender.Male,
        agePreference: AgePreference(from: 18, to: 99),
        alcoholPreference: AlcoholType.Beer,
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
        location: Location(latitude: 50.44, longtitude: 56.78),
        friends: null),
    User(id: null,
        name: "Harnas",
        email: null,
        gender: Gender.Male,
        age: 22,
        description: "Harnas, piwo z gór",
        favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
        genderPreference: Gender.Male,
        agePreference: AgePreference(from: 18, to: 99),
        alcoholPreference: AlcoholType.Beer,
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
        location: Location(latitude: 50.44, longtitude: 56.78),
        friends: null),
    User(id: null,
        name: "Harnas",
        email: null,
        gender: Gender.Male,
        age: 22,
        description: "Harnas, piwo z gór",
        favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
        genderPreference: Gender.Male,
        agePreference: AgePreference(from: 18, to: 99),
        alcoholPreference: AlcoholType.Beer,
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
        location: Location(latitude: 50.44, longtitude: 56.78),
        friends: null),
  ]);
}

User getUser(){
  return User(id: null,
      name: "Harnas",
      email: null,
      gender: Gender.Male,
      age: 18,
      description: "Harnas, piwo z gór",
      favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
      genderPreference: Gender.Male,
      agePreference: AgePreference(from: 18, to: 99),
      alcoholPreference: AlcoholType.Beer,
      imageUrl: "https://wygraland.pl/wp-content/uploads/2017/02/harnas-1.jpg",
      location: Location(latitude: 50.44, longtitude: 56.78),
      friends: null);
}