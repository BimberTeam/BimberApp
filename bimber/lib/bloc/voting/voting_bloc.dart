import 'dart:async';
import 'package:bimber/models/group_candidate.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/repositories.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'voting_event.dart';
part 'voting_state.dart';

class VotingBloc extends Bloc<VotingEvent, VotingState> {
  final GroupRepository groupRepository;
  final String groupId;

  VotingBloc({@required this.groupRepository, @required this.groupId})
      : super(VotingInitial());

  @override
  Stream<VotingState> mapEventToState(
    VotingEvent event,
  ) async* {
    if (event is InitVoting) {
      yield* _fetchVoting();
    }
    if (event is RefetchVoting) {
      yield VotingLoading();
      yield* _fetchVoting();
    }
    if (event is VoteFor) {
      yield* _mapVoteForToState(event);
    }
    if (event is VoteAgainst) {
      yield* _mapVoteAgainstToState(event);
    }
  }

  Stream<VotingState> _mapVoteForToState(VoteFor event) async* {
    try {
      yield VotingLoading();
      bool voted = await groupRepository.voteFor(groupId, event.id);
      yield voted ? VotingSuccess() : VotingFailure();
      yield* _fetchVoting();
    } catch (exception) {
      yield* _handleException(exception);
    }
  }

  Stream<VotingState> _mapVoteAgainstToState(VoteAgainst event) async* {
    try {
      yield VotingLoading();
      bool voted = await groupRepository.voteAgainst(groupId, event.id);
      yield voted ? VotingSuccess() : VotingFailure();
      yield* _fetchVoting();
    } catch (exception) {
      yield* _handleException(exception);
    }
  }

  Stream<VotingState> _fetchVoting() async* {
    try {
      List<User> groupCandidates =
          await groupRepository.fetchCandidatesForVote(groupId);
      List<GroupCandidate> votingResults =
          await groupRepository.fetchGroupCandidates(groupId);
      yield VotingFetched(groupCandidates, votingResults);
    } catch (exception) {
      yield* _handleException(exception);
    }
  }

  Stream<VotingState> _handleException(exception) async* {
    if (exception is TimeoutException)
      yield VotingError(message: timeoutExceptionMessage);
    else
      yield VotingError(message: defaultErrorMessage);
  }
}
