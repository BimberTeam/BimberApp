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
  final String id;

  VoteFor({@required this.id});

  @override
  List<Object> get props => [id];
}

class VoteAgainst extends VotingEvent {
  final String id;

  VoteAgainst({@required this.id});

  @override
  List<Object> get props => [id];
}
