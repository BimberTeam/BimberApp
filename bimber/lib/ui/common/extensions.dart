import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/edit_account_data.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:bimber/models/alcohol_type.dart";
import "package:bimber/models/gender.dart";

extension ChatThumbnailExtension on ChatThumbnail {
  Future<bool> checkIfRead() async {
    if (lastMessage == null) return true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(this.id);
    if (value != null) {
      DateTime lastRead = DateTime.parse(value);
      if (lastRead.isAfter(this.lastMessage.date)) return true;
    }
    return false;
  }

  markAsRead() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.id, DateTime.now().toIso8601String());
  }
}

extension RegisterAccountDataExtension on RegisterAccountData{
  Map<String, dynamic> toJsonForRegister() {
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
      "password": password,
    };
  }
}

extension EditAccountDataExtension on EditAccountData{
  Map<String, dynamic> toJsonForEdit() {
    return {
      "name": name,
      "gender": gender?.toJson(),
      "age": age,
      "description": description,
      "favoriteAlcoholName": favoriteAlcoholName,
      "favoriteAlcoholType": favoriteAlcoholType?.toJson(),
      "genderPreference": genderPreference?.toJson(),
      "agePreferenceFrom": agePreferenceFrom,
      "agePreferenceTo": agePreferenceTo
    };
  }

}
