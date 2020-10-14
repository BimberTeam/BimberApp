import 'package:bimber/models/alcohol_type.dart';
import 'package:bimber/models/gender.dart';

extension ReadableGender on Gender {
  String readable() {
    switch (this) {
      case Gender.MALE:
        return "Mężczyzna";
      case Gender.FEMALE:
        return "Kobieta";
      default:
        return "Blip Bloop!";
    }
  }
}

extension ReadableAlcoholType on AlcoholType {
  String readable() {
    switch (this) {
      case AlcoholType.BEER:
        return "Piwo";
      case AlcoholType.WINE:
        return "Wino";
      case AlcoholType.VODKA:
        return "Wódka";
      case AlcoholType.OTHER:
        return "Inne";
      default:
        return "Blip Bloop!";
    }
  }
}
