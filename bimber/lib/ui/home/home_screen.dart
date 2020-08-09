import 'package:bimber/models/age_preference.dart';
import 'package:bimber/models/alcohol.dart';
import 'package:bimber/models/alcohol_type.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/models/location.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/ui/details/user_details.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserDetails(user: User(id: null,
        name: "Harnas",
        email: null,
        gender: Gender.Male,
        age: 6,
        description: "Harnas, piwo z gór",
        favoriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
        genderPreference: Gender.Male,
        agePreference: AgePreference(from: 18, to: 99),
        alcoholPreference: AlcoholType.Beer,
        imagePath: "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.png",
        location: Location(latitude: 50.44, longtitude: 56.78),
        friends: null));
  }
}
