import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/location.dart";
import "package:bimber/models/alcohol_type.dart";
import "package:bimber/models/gender.dart";

class User extends Equatable {
  bool get stringify => true;

  final String id;
  final String name;
  final Gender gender;
  final int age;
  final String description;
  final AlcoholType favoriteAlcoholType;
  final String favoriteAlcoholName;
  final Location latestLocation;

  User(
      {@required this.id,
      @required this.name,
      @required this.gender,
      @required this.age,
      @required this.description,
      @required this.favoriteAlcoholType,
      @required this.favoriteAlcoholName,
      @required this.latestLocation});

  User copyWith(
      {String id,
      String name,
      Gender gender,
      int age,
      String description,
      AlcoholType favoriteAlcoholType,
      String favoriteAlcoholName,
      Location latestLocation}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        description: description ?? this.description,
        favoriteAlcoholType: favoriteAlcoholType ?? this.favoriteAlcoholType,
        favoriteAlcoholName: favoriteAlcoholName ?? this.favoriteAlcoholName,
        latestLocation: latestLocation ?? this.latestLocation);
  }

  @override
  List get props => [
        id,
        name,
        gender,
        age,
        description,
        favoriteAlcoholType,
        favoriteAlcoholName,
        latestLocation
      ];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "gender": gender?.toJson(),
      "age": age,
      "description": description,
      "favoriteAlcoholType": favoriteAlcoholType?.toJson(),
      "favoriteAlcoholName": favoriteAlcoholName,
      "latestLocation": latestLocation?.toJson()
    };
  }

  factory User.fromJson(dynamic json) {
    if (json == null) return null;
    return User(
        id: json["id"],
        name: json["name"],
        gender: GenderExtension.fromJson(json["gender"]),
        age: json["age"] as int,
        description: json["description"],
        favoriteAlcoholType:
            AlcoholTypeExtension.fromJson(json["favoriteAlcoholType"]),
        favoriteAlcoholName: json["favoriteAlcoholName"],
        latestLocation: Location.fromJson(json["latestLocation"]));
  }
}
