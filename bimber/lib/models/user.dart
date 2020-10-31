import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/alcohol_type.dart";
import "package:bimber/models/location.dart";
import "package:bimber/models/gender.dart";
import "package:bimber/models/user.dart";

class User extends Equatable {
  bool get stringify => true;

  final String id;
  final String name;
  final String email;
  final Gender gender;
  final int age;
  final String description;
  final AlcoholType favoriteAlcoholType;
  final String favoriteAlcoholName;
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
      @required this.favoriteAlcoholType,
      @required this.favoriteAlcoholName,
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
      AlcoholType favoriteAlcoholType,
      String favoriteAlcoholName,
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
        favoriteAlcoholType: favoriteAlcoholType ?? this.favoriteAlcoholType,
        favoriteAlcoholName: favoriteAlcoholName ?? this.favoriteAlcoholName,
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
        favoriteAlcoholType,
        favoriteAlcoholName,
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
      "favoriteAlcoholType": favoriteAlcoholType?.toJson(),
      "favoriteAlcoholName": favoriteAlcoholName,
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
        favoriteAlcoholType:
            AlcoholTypeExtension.fromJson(json["favoriteAlcoholType"]),
        favoriteAlcoholName: json["favoriteAlcoholName"],
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
