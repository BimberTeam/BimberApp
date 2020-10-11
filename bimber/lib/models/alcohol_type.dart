enum AlcoholType { BEER, WINE, VODKA, OTHER }

extension AlcoholTypeExtension on AlcoholType {
  String toJson() {
    switch (this) {
      case AlcoholType.BEER:
        return "BEER";
      case AlcoholType.WINE:
        return "WINE";
      case AlcoholType.VODKA:
        return "VODKA";
      case AlcoholType.OTHER:
        return "OTHER";
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
