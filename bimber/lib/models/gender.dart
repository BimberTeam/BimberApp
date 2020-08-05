enum Gender { Male, Female }

extension GenderExtension on Gender {
  String toJson() {
    switch (this) {
      case Gender.Male:
        return "male";
      case Gender.Female:
        return "female";
      default:
        return null;
    }
  }

  static Gender fromJson(String name) {
    switch (name) {
      case "male":
        return Gender.Male;
      case "female":
        return Gender.Female;
      default:
        return null;
    }
  }
}
