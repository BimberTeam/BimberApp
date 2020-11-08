import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/user.dart";

class GroupCandidate extends Equatable {
  bool get stringify => true;

  final User user;
  final int votesAgainst;
  final int votesInFavour;
  final int groupCount;

  GroupCandidate(
      {@required this.user,
      @required this.votesAgainst,
      @required this.votesInFavour,
      @required this.groupCount});

  GroupCandidate copyWith(
      {User user, int votesAgainst, int votesInFavour, int groupCount}) {
    return GroupCandidate(
        user: user ?? this.user,
        votesAgainst: votesAgainst ?? this.votesAgainst,
        votesInFavour: votesInFavour ?? this.votesInFavour,
        groupCount: groupCount ?? this.groupCount);
  }

  @override
  List get props => [user, votesAgainst, votesInFavour, groupCount];

  Map<String, dynamic> toJson() {
    return {
      "user": user?.toJson(),
      "votesAgainst": votesAgainst,
      "votesInFavour": votesInFavour,
      "groupCount": groupCount
    };
  }

  factory GroupCandidate.fromJson(dynamic json) {
    if (json == null) return null;
    return GroupCandidate(
        user: User.fromJson(json["user"]),
        votesAgainst: json["votesAgainst"] as int,
        votesInFavour: json["votesInFavour"] as int,
        groupCount: json["groupCount"] as int);
  }
}
