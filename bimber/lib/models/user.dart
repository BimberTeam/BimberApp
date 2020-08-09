import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/gender.dart";
import "package:bimber/models/age_preference.dart";
import "package:bimber/models/alcohol_type.dart";
import "package:bimber/models/alcohol.dart";
import "package:bimber/models/user.dart";
import "package:bimber/models/location.dart";

class User extends Equatable {
  bool get stringify => true;

  final String id;
  final String name;
  final String email;
  final Gender gender;
  final int age;
  final String description;
  final Alcohol favoriteAlcohol;
  final Gender genderPreference;
  final AgePreference agePreference;
  final AlcoholType alcoholPreference;
  final String imagePath;
  final Location location;
  final List<User> friends;

  User(
      {@required this.id,
      @required this.name,
      @required this.email,
      @required this.gender,
      @required this.age,
      @required this.description,
      @required this.favoriteAlcohol,
      @required this.genderPreference,
      @required this.agePreference,
      @required this.alcoholPreference,
      @required this.imagePath,
      @required this.location,
      @required this.friends});

  User copyWith(
      {String id,
      String name,
      String email,
      Gender gender,
      int age,
      String description,
      Alcohol favoriteAlcohol,
      Gender genderPreference,
      AgePreference agePreference,
      AlcoholType alcoholPreference,
      String imagePath,
      Location location,
      List<User> friends}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        description: description ?? this.description,
        favoriteAlcohol: favoriteAlcohol ?? this.favoriteAlcohol,
        genderPreference: genderPreference ?? this.genderPreference,
        agePreference: agePreference ?? this.agePreference,
        alcoholPreference: alcoholPreference ?? this.alcoholPreference,
        imagePath: imagePath ?? this.imagePath,
        location: location ?? this.location,
        friends: friends ?? this.friends);
  }

  @override
  List get props => [
        id,
        name,
        email,
        gender,
        age,
        description,
        favoriteAlcohol,
        genderPreference,
        agePreference,
        alcoholPreference,
        imagePath,
        location,
        friends
      ];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "gender": gender?.toJson(),
      "age": age,
      "description": description,
      "favoriteAlcohol": favoriteAlcohol?.toJson(),
      "genderPreference": genderPreference?.toJson(),
      "agePreference": agePreference?.toJson(),
      "alcoholPreference": alcoholPreference?.toJson(),
      "imagePath": imagePath,
      "location": location?.toJson(),
      "friends": friends.map((e) => e?.toJson())
    };
  }

  factory User.fromJson(dynamic json) {
    if (json == null) return null;
    return User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: GenderExtension.fromJson(json["gender"]),
        age: json["age"] as int,
        description: json["description"],
        favoriteAlcohol: Alcohol.fromJson(json["favoriteAlcohol"]),
        genderPreference: GenderExtension.fromJson(json["genderPreference"]),
        agePreference: AgePreference.fromJson(json["agePreference"]),
        alcoholPreference:
            AlcoholTypeExtension.fromJson(json["alcoholPreference"]),
        imagePath: json["imagePath"],
        location: Location.fromJson(json["location"]),
        friends: json["friends"].map((e) => User.fromJson(e)).toList());
  }
}
