import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/location.dart";
import "package:bimber/models/alcohol.dart";
import "package:bimber/models/alcohol_type.dart";
import "package:bimber/models/gender.dart";

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
  final int agePreferenceFrom;
  final int agePreferenceTo;
  final AlcoholType alcoholPreference;
  final String imageUrl;
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
      @required this.agePreferenceFrom,
      @required this.agePreferenceTo,
      @required this.alcoholPreference,
      @required this.imageUrl,
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
      int agePreferenceFrom,
      int agePreferenceTo,
      AlcoholType alcoholPreference,
      String imageUrl,
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
        agePreferenceFrom: agePreferenceFrom ?? this.agePreferenceFrom,
        agePreferenceTo: agePreferenceTo ?? this.agePreferenceTo,
        alcoholPreference: alcoholPreference ?? this.alcoholPreference,
        imageUrl: imageUrl ?? this.imageUrl,
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
        agePreferenceFrom,
        agePreferenceTo,
        alcoholPreference,
        imageUrl,
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
      "agePreferenceFrom": agePreferenceFrom,
      "agePreferenceTo": agePreferenceTo,
      "alcoholPreference": alcoholPreference?.toJson(),
      "imageUrl": imageUrl,
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
        agePreferenceFrom: json["agePreferenceFrom"] as int,
        agePreferenceTo: json["agePreferenceTo"] as int,
        alcoholPreference:
            AlcoholTypeExtension.fromJson(json["alcoholPreference"]),
        imageUrl: json["imageUrl"],
        location: Location.fromJson(json["location"]),
        friends: json["friends"].map((e) => User.fromJson(e)).toList());
  }
}
