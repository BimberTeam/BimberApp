import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Location extends Equatable {
  bool get stringify => true;

  final double latitude;
  final double longitude;

  Location({@required this.latitude, @required this.longitude});

  Location copyWith({double latitude, double longitude}) {
    return Location(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude);
  }

  @override
  List get props => [latitude, longitude];

  Map<String, dynamic> toJson() {
    return {"latitude": latitude, "longitude": longitude};
  }

  factory Location.fromJson(dynamic json) {
    if (json == null) return null;
    return Location(
        latitude: json["latitude"] as double,
        longitude: json["longitude"] as double);
  }
}
