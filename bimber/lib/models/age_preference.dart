import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AgePreference extends Equatable {
  final int from;
  final int to;

  AgePreference({@required this.from, @required this.to});

  AgePreference copyWith({int from, int to}) {
    return AgePreference(from: from ?? this.from, to: to ?? this.to);
  }

  @override
  List get props => [from, to];

  Map<String, dynamic> toJson() {
    return {"from": from, "to": to};
  }

  factory AgePreference.fromJson(dynamic json) {
    return AgePreference(from: json["from"] as int, to: json["to"] as int);
  }
}
