import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/gender.dart";
import "package:bimber/models/user.dart";
import "package:bimber/models/location.dart";
import "package:bimber/models/alcohol.dart";
import "package:bimber/models/age_preference.dart";
import "package:bimber/models/alcohol_type.dart";

class User extends Equatable {
  bool get stringify => true;

  final String id;
  final String name;
  final String email;
  final Gender gender;
  final int age;
  final String description;
  final Alcohol favouriteAlcohol;
  final Gender genderPreference;
  final AgePreference agePreference;
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
      @required this.favouriteAlcohol,
      @required this.genderPreference,
      @required this.agePreference,
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
      Alcohol favouriteAlcohol,
      Gender genderPreference,
      AgePreference agePreference,
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
        favouriteAlcohol: favouriteAlcohol ?? this.favouriteAlcohol,
        genderPreference: genderPreference ?? this.genderPreference,
        agePreference: agePreference ?? this.agePreference,
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
        favouriteAlcohol,
        genderPreference,
        agePreference,
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
      "favouriteAlcohol": favouriteAlcohol?.toJson(),
      "genderPreference": genderPreference?.toJson(),
      "agePreference": agePreference?.toJson(),
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
        favouriteAlcohol: Alcohol.fromJson(json["favouriteAlcohol"]),
        genderPreference: GenderExtension.fromJson(json["genderPreference"]),
        agePreference: AgePreference.fromJson(json["agePreference"]),
        alcoholPreference:
            AlcoholTypeExtension.fromJson(json["alcoholPreference"]),
        imageUrl: json["imageUrl"],
        location: Location.fromJson(json["location"]),
        friends: json["friends"].map((e) => User.fromJson(e)).toList());
  }
}
