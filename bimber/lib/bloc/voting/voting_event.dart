part of 'voting_bloc.dart';

@immutable
abstract class VotingEvent extends Equatable {
  const VotingEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitVoting extends VotingEvent {}

class RefetchVoting extends VotingEvent {}

class VoteFor extends VotingEvent {
  final String userId;

  VoteFor({@required this.userId});

  @override
  List<Object> get props => [userId];
}

class VoteAgainst extends VotingEvent {
  final String userId;

  VoteAgainst({@required this.userId});

  @override
  List<Object> get props => [userId];
}
