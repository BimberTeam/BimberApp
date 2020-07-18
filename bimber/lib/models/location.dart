import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Location extends Equatable {
  final double latitude;
  final double longtitude;

  Location({@required this.latitude, @required this.longtitude});

  Location copyWith({double latitude, double longtitude}) {
    return Location(
        latitude: latitude ?? this.latitude,
        longtitude: longtitude ?? this.longtitude);
  }

  @override
  List get props => [latitude, longtitude];
}
