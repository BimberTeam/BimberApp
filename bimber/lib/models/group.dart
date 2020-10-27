import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/user.dart";
import "package:bimber/models/location.dart";

class Group extends Equatable {
  bool get stringify => true;

  final String id;
  final List<User> members;
  final double averageAge;
  final Location averageLocation;

  Group(
      {@required this.id,
      @required this.members,
      @required this.averageAge,
      @required this.averageLocation});

  Group copyWith(
      {String id,
      List<User> members,
      double averageAge,
      Location averageLocation}) {
    return Group(
        id: id ?? this.id,
        members: members ?? this.members,
        averageAge: averageAge ?? this.averageAge,
        averageLocation: averageLocation ?? this.averageLocation);
  }

  @override
  List get props => [id, members, averageAge, averageLocation];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "members": members.map((e) => e?.toJson()),
      "averageAge": averageAge,
      "averageLocation": averageLocation?.toJson()
    };
  }

  factory Group.fromJson(dynamic json) {
    if (json == null) return null;
    return Group(
        id: json["id"],
        members: List<User>.from(json["members"].map((e) => User.fromJson(e))),
        averageAge: json["averageAge"] as double,
        averageLocation: Location.fromJson(json["averageLocation"]));
  }
}
