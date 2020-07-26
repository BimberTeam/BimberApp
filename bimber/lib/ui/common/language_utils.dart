import 'package:bimber/models/alcohol_type.dart';
import 'package:bimber/models/gender.dart';

extension ReadableGender on Gender {
  String readable() {
    switch (this) {
      case Gender.Male:
        return "Mężczyzna";
      case Gender.Female:
        return "Kobieta";
      default:
        return "Blip Bloop!";
    }
  }
}

extension ReadableAlcoholType on AlcoholType {
  String readable() {
    switch (this) {
      case AlcoholType.Beer:
        return "Piwo";
      case AlcoholType.Wine:
        return "Wino";
      case AlcoholType.Vodka:
        return "Wódka";
      case AlcoholType.Other:
        return "Inne";
      default:
        return "Blip Bloop!";
    }
  }
}
