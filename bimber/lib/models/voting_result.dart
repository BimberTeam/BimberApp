import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/user.dart";

class VotingResult extends Equatable {
  bool get stringify => true;

  final User user;
  final int votesAgainst;
  final int votesInFavour;
  final int groupCount;

  VotingResult(
      {@required this.user,
      @required this.votesAgainst,
      @required this.votesInFavour,
      @required this.groupCount});

  VotingResult copyWith(
      {User user, int votesAgainst, int votesInFavour, int groupCount}) {
    return VotingResult(
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

  factory VotingResult.fromJson(dynamic json) {
    if (json == null) return null;
    return VotingResult(
        user: User.fromJson(json["user"]),
        votesAgainst: json["votesAgainst"] as int,
        votesInFavour: json["votesInFavour"] as int,
        groupCount: json["groupCount"] as int);
  }
}
