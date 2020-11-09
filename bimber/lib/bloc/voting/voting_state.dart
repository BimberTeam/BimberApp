part of 'voting_bloc.dart';

@immutable
abstract class VotingState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class VotingInitial extends VotingState {}

class VotingError extends VotingState {
  final String message;

  VotingError({@required this.message});

  @override
  List<Object> get props => [message];
}

class VotingFetched extends VotingState {
  final List<User> groupCandidates;
  final List<GroupCandidate> votingResults;

  VotingFetched(this.groupCandidates, this.votingResults);

  @override
  List<Object> get props => [this.groupCandidates, this.votingResults];
}

class VotingLoading extends VotingState {}

class VotingSuccess extends VotingState {}

class VotingFailure extends VotingState {}
