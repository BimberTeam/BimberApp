import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/gender.dart";
import "package:bimber/models/alcohol_type.dart";

class AccountData extends Equatable {
  bool get stringify => true;

  final String name;
  final String email;
  final Gender gender;
  final int age;
  final String description;
  final String favoriteAlcoholName;
  final AlcoholType favoriteAlcoholType;
  final Gender genderPreference;
  final int agePreferenceFrom;
  final int agePreferenceTo;
  final AlcoholType alcoholPreference;
  final String imageUrl;

  AccountData(
      {@required this.name,
      @required this.email,
      @required this.gender,
      @required this.age,
      @required this.description,
      @required this.favoriteAlcoholName,
      @required this.favoriteAlcoholType,
      @required this.genderPreference,
      @required this.agePreferenceFrom,
      @required this.agePreferenceTo,
      @required this.alcoholPreference,
      @required this.imageUrl});

  AccountData copyWith(
      {String name,
      String email,
      Gender gender,
      int age,
      String description,
      String favoriteAlcoholName,
      AlcoholType favoriteAlcoholType,
      Gender genderPreference,
      int agePreferenceFrom,
      int agePreferenceTo,
      AlcoholType alcoholPreference,
      String imageUrl}) {
    return AccountData(
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        description: description ?? this.description,
        favoriteAlcoholName: favoriteAlcoholName ?? this.favoriteAlcoholName,
        favoriteAlcoholType: favoriteAlcoholType ?? this.favoriteAlcoholType,
        genderPreference: genderPreference ?? this.genderPreference,
        agePreferenceFrom: agePreferenceFrom ?? this.agePreferenceFrom,
        agePreferenceTo: agePreferenceTo ?? this.agePreferenceTo,
        alcoholPreference: alcoholPreference ?? this.alcoholPreference,
        imageUrl: imageUrl ?? this.imageUrl);
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
        agePreferenceFrom,
        agePreferenceTo,
        alcoholPreference,
        imageUrl
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
      "agePreferenceFrom": agePreferenceFrom,
      "agePreferenceTo": agePreferenceTo,
      "alcoholPreference": alcoholPreference?.toJson(),
      "imageUrl": imageUrl
    };
  }

  factory AccountData.fromJson(dynamic json) {
    if (json == null) return null;
    return AccountData(
        name: json["name"],
        email: json["email"],
        gender: GenderExtension.fromJson(json["gender"]),
        age: json["age"] as int,
        description: json["description"],
        favoriteAlcoholName: json["favoriteAlcoholName"],
        favoriteAlcoholType:
            AlcoholTypeExtension.fromJson(json["favoriteAlcoholType"]),
        genderPreference: GenderExtension.fromJson(json["genderPreference"]),
        agePreferenceFrom: json["agePreferenceFrom"] as int,
        agePreferenceTo: json["agePreferenceTo"] as int,
        alcoholPreference:
            AlcoholTypeExtension.fromJson(json["alcoholPreference"]),
        imageUrl: json["imageUrl"]);
  }
}
