import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/alcohol_type.dart";
import "package:bimber/models/gender.dart";
import "package:bimber/models/alcohol.dart";
import "package:bimber/models/age_preference.dart";

class RegisterAccountData extends Equatable {
  bool get stringify => true;

  final String name;
  final String email;
  final Gender gender;
  final int age;
  final String description;
  final Alcohol favoriteAlcohol;
  final Gender genderPreference;
  final AgePreference agePreference;
  final AlcoholType alcoholPreference;
  final String password;
  final String imagePath;

  RegisterAccountData(
      {@required this.name,
      @required this.email,
      @required this.gender,
      @required this.age,
      @required this.description,
      @required this.favoriteAlcohol,
      @required this.genderPreference,
      @required this.agePreference,
      @required this.alcoholPreference,
      @required this.password,
      @required this.imagePath});

  RegisterAccountData copyWith(
      {String name,
      String email,
      Gender gender,
      int age,
      String description,
      Alcohol favoriteAlcohol,
      Gender genderPreference,
      AgePreference agePreference,
      AlcoholType alcoholPreference,
      String password,
      String imagePath}) {
    return RegisterAccountData(
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        description: description ?? this.description,
        favoriteAlcohol: favoriteAlcohol ?? this.favoriteAlcohol,
        genderPreference: genderPreference ?? this.genderPreference,
        agePreference: agePreference ?? this.agePreference,
        alcoholPreference: alcoholPreference ?? this.alcoholPreference,
        password: password ?? this.password,
        imagePath: imagePath ?? this.imagePath);
  }

  @override
  List get props => [
        name,
        email,
        gender,
        age,
        description,
        favoriteAlcohol,
        genderPreference,
        agePreference,
        alcoholPreference,
        password,
        imagePath
      ];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "gender": gender?.toJson(),
      "age": age,
      "description": description,
      "favoriteAlcohol": favoriteAlcohol?.toJson(),
      "genderPreference": genderPreference?.toJson(),
      "agePreference": agePreference?.toJson(),
      "alcoholPreference": alcoholPreference?.toJson(),
      "password": password,
      "imagePath": imagePath
    };
  }

  factory RegisterAccountData.fromJson(dynamic json) {
    if (json == null) return null;
    return RegisterAccountData(
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
        password: json["password"],
        imagePath: json["imagePath"]);
  }
}
