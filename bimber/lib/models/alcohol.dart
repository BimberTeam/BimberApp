import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/alcohol_type.dart";

class Alcohol extends Equatable {
  final String name;
  final AlcoholType type;

  Alcohol({@required this.name, @required this.type});

  Alcohol copyWith({String name, AlcoholType type}) {
    return Alcohol(name: name ?? this.name, type: type ?? this.type);
  }

  @override
  List get props => [name, type];

  Map<String, dynamic> toJson() {
    return {"name": name, "type": type?.toJson()};
  }

  factory Alcohol.fromJson(dynamic json) {
    return Alcohol(
        name: json["name"], type: AlcoholTypeExtension.fromJson(json["type"]));
  }
}
