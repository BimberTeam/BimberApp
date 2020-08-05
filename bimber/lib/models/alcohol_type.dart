enum AlcoholType { Beer, Wine, Vodka, Other }

extension AlcoholTypeExtension on AlcoholType {
  String toJson() {
    switch (this) {
      case AlcoholType.Beer:
        return "beer";
      case AlcoholType.Wine:
        return "wine";
      case AlcoholType.Vodka:
        return "vodka";
      case AlcoholType.Other:
        return "other";
      default:
        return null;
    }
  }

  static AlcoholType fromJson(String name) {
    switch (name) {
      case "beer":
        return AlcoholType.Beer;
      case "wine":
        return AlcoholType.Wine;
      case "vodka":
        return AlcoholType.Vodka;
      case "other":
        return AlcoholType.Other;
      default:
        return null;
    }
  }
}
