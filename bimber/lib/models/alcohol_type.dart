enum AlcoholType { BEER, WINE, VODKA, OTHER }

extension AlcoholTypeExtension on AlcoholType {
  String toJson() {
    switch (this) {
      case AlcoholType.BEER:
        return "Beer";
      case AlcoholType.WINE:
        return "Wine";
      case AlcoholType.VODKA:
        return "Vodka";
      case AlcoholType.OTHER:
        return "Other";
      default:
        return null;
    }
  }

  static AlcoholType fromJson(String name) {
    switch (name) {
      case "BEER":
        return AlcoholType.BEER;
      case "WINE":
        return AlcoholType.WINE;
      case "VODKA":
        return AlcoholType.VODKA;
      case "OTHER":
        return AlcoholType.OTHER;
      default:
        return null;
    }
  }
}
