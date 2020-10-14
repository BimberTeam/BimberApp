enum Gender { MALE, FEMALE }

extension GenderExtension on Gender {
  String toJson() {
    switch (this) {
      case Gender.MALE:
        return "MALE";
      case Gender.FEMALE:
        return "FEMALE";
      default:
        return null;
    }
  }

  static Gender fromJson(String name) {
    switch (name) {
      case "MALE":
        return Gender.MALE;
      case "FEMALE":
        return Gender.FEMALE;
      default:
        return null;
    }
  }
}
