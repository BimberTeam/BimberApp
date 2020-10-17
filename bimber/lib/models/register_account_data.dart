import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/alcohol_type.dart";
import "package:bimber/models/age_preference.dart";
import "package:bimber/models/gender.dart";

class RegisterAccountData extends Equatable {
  bool get stringify => true;

  final String name;
  final String email;
  final Gender gender;
  final int age;
  final String description;
  final String favoriteAlcoholName;
  final AlcoholType favoriteAlcoholType;
  final Gender genderPreference;
  final AgePreference agePreference;
  final int agePreferenceFrom;
  final int agePreferenceTo;
  final AlcoholType alcoholPreference;
  final String password;
  final String imagePath;

  RegisterAccountData(
      {@required this.name,
      @required this.email,
      @required this.gender,
      @required this.age,
      @required this.description,
      @required this.favoriteAlcoholName,
      @required this.favoriteAlcoholType,
      @required this.genderPreference,
      @required this.agePreference,
      @required this.agePreferenceFrom,
      @required this.agePreferenceTo,
      @required this.alcoholPreference,
      @required this.password,
      @required this.imagePath});

  RegisterAccountData copyWith(
      {String name,
      String email,
      Gender gender,
      int age,
      String description,
      String favoriteAlcoholName,
      AlcoholType favoriteAlcoholType,
      Gender genderPreference,
      AgePreference agePreference,
      int agePreferenceFrom,
      int agePreferenceTo,
      AlcoholType alcoholPreference,
      String password,
      String imagePath}) {
    return RegisterAccountData(
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        description: description ?? this.description,
        favoriteAlcoholName: favoriteAlcoholName ?? this.favoriteAlcoholName,
        favoriteAlcoholType: favoriteAlcoholType ?? this.favoriteAlcoholType,
        genderPreference: genderPreference ?? this.genderPreference,
        agePreference: agePreference ?? this.agePreference,
        agePreferenceFrom: agePreferenceFrom ?? this.agePreferenceFrom,
        agePreferenceTo: agePreferenceTo ?? this.agePreferenceTo,
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
        favoriteAlcoholName,
        favoriteAlcoholType,
        genderPreference,
        agePreference,
        agePreferenceFrom,
        agePreferenceTo,
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
      "favoriteAlcoholName": favoriteAlcoholName,
      "favoriteAlcoholType": favoriteAlcoholType?.toJson(),
      "genderPreference": genderPreference?.toJson(),
      "agePreference": agePreference?.toJson(),
      "agePreferenceFrom": agePreferenceFrom,
      "agePreferenceTo": agePreferenceTo,
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
        favoriteAlcoholName: json["favoriteAlcoholName"],
        favoriteAlcoholType:
            AlcoholTypeExtension.fromJson(json["favoriteAlcoholType"]),
        genderPreference: GenderExtension.fromJson(json["genderPreference"]),
        agePreference: AgePreference.fromJson(json["agePreference"]),
        agePreferenceFrom: json["agePreferenceFrom"] as int,
        agePreferenceTo: json["agePreferenceTo"] as int,
        alcoholPreference:
            AlcoholTypeExtension.fromJson(json["alcoholPreference"]),
        password: json["password"],
        imagePath: json["imagePath"]);
  }
}
