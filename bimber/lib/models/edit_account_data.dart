import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/gender.dart";
import "package:bimber/models/alcohol_type.dart";

class EditAccountData extends Equatable {
  bool get stringify => true;

  final String id;
  final String name;
  final Gender gender;
  final int age;
  final String description;
  final String favoriteAlcoholName;
  final AlcoholType favoriteAlcoholType;
  final Gender genderPreference;
  final int agePreferenceFrom;
  final int agePreferenceTo;
  final AlcoholType alcoholPreference;
  final String imagePath;

  EditAccountData(
      {@required this.id,
      @required this.name,
      @required this.gender,
      @required this.age,
      @required this.description,
      @required this.favoriteAlcoholName,
      @required this.favoriteAlcoholType,
      @required this.genderPreference,
      @required this.agePreferenceFrom,
      @required this.agePreferenceTo,
      @required this.alcoholPreference,
      @required this.imagePath});

  EditAccountData copyWith(
      {String id,
      String name,
      Gender gender,
      int age,
      String description,
      String favoriteAlcoholName,
      AlcoholType favoriteAlcoholType,
      Gender genderPreference,
      int agePreferenceFrom,
      int agePreferenceTo,
      AlcoholType alcoholPreference,
      String imagePath}) {
    return EditAccountData(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        description: description ?? this.description,
        favoriteAlcoholName: favoriteAlcoholName ?? this.favoriteAlcoholName,
        favoriteAlcoholType: favoriteAlcoholType ?? this.favoriteAlcoholType,
        genderPreference: genderPreference ?? this.genderPreference,
        agePreferenceFrom: agePreferenceFrom ?? this.agePreferenceFrom,
        agePreferenceTo: agePreferenceTo ?? this.agePreferenceTo,
        alcoholPreference: alcoholPreference ?? this.alcoholPreference,
        imagePath: imagePath ?? this.imagePath);
  }

  @override
  List get props => [
        id,
        name,
        gender,
        age,
        description,
        favoriteAlcoholName,
        favoriteAlcoholType,
        genderPreference,
        agePreferenceFrom,
        agePreferenceTo,
        alcoholPreference,
        imagePath
      ];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "gender": gender?.toJson(),
      "age": age,
      "description": description,
      "favoriteAlcoholName": favoriteAlcoholName,
      "favoriteAlcoholType": favoriteAlcoholType?.toJson(),
      "genderPreference": genderPreference?.toJson(),
      "agePreferenceFrom": agePreferenceFrom,
      "agePreferenceTo": agePreferenceTo,
      "alcoholPreference": alcoholPreference?.toJson(),
      "imagePath": imagePath
    };
  }

  factory EditAccountData.fromJson(dynamic json) {
    if (json == null) return null;
    return EditAccountData(
        id: json["id"],
        name: json["name"],
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
        imagePath: json["imagePath"]);
  }
}
