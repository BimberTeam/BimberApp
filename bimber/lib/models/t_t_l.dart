import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TTL extends Equatable {
  bool get stringify => true;

  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final int second;

  TTL(
      {@required this.year,
      @required this.month,
      @required this.day,
      @required this.hour,
      @required this.minute,
      @required this.second});

  TTL copyWith(
      {int year, int month, int day, int hour, int minute, int second}) {
    return TTL(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second);
  }

  @override
  List get props => [year, month, day, hour, minute, second];

  Map<String, dynamic> toJson() {
    return {
      "year": year,
      "month": month,
      "day": day,
      "hour": hour,
      "minute": minute,
      "second": second
    };
  }

  factory TTL.fromJson(dynamic json) {
    if (json == null) return null;
    return TTL(
        year: json["year"] as int,
        month: json["month"] as int,
        day: json["day"] as int,
        hour: json["hour"] as int,
        minute: json["minute"] as int,
        second: json["second"] as int);
  }
}
