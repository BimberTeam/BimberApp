import 'dart:async';

import 'package:bimber/models/user.dart';
import 'package:bimber/resources/friend_repository.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'friend_requests_event.dart';
part 'friend_requests_state.dart';

class FriendRequestBloc extends Bloc<FriendRequestEvent, FriendRequestState> {
  final FriendRepository friendRepository;
  List<User> _cachedRequests;

  FriendRequestBloc({@required this.friendRepository})
      : super(FriendRequestsInitial());

  @override
  Stream<FriendRequestState> mapEventToState(
    FriendRequestEvent event,
  ) async* {
    if (event is InitFriendRequests) {
      yield* _fetchFriendsRequests();
    }
    if (event is RefetchFriendRequests) {
      yield* _mapRefreshFriendRequestsToState(event);
    }
    if (event is DeclineFriendRequest) {
      yield* _mapToState(() async* {
        bool canceledFriend =
            await friendRepository.cancelInvitation(event.friendId);
        List<User> requests =
            await friendRepository.fetchFriendInvitationList();
        _cachedRequests = requests;
        yield canceledFriend
            ? FriendRequestsDeclineSuccess(requests: requests)
            : FriendRequestsDeclineError(requests: requests);
      });
    }
    if (event is AcceptFriendRequest) {
      yield* _mapToState(() async* {
        bool acceptedFriend =
            await friendRepository.acceptInvitation(event.friendId);
        List<User> requests =
            await friendRepository.fetchFriendInvitationList();
        _cachedRequests = requests;
        yield acceptedFriend
            ? FriendRequestsAcceptSuccess(requests: requests)
            : FriendRequestsAcceptError(requests: requests);
      });
    }
  }

  Stream<FriendRequestState> _mapRefreshFriendRequestsToState(
      RefetchFriendRequests event) async* {
    yield FriendRequestsLoading(requests: _cachedRequests);
    yield* _fetchFriendsRequests();
  }

  Stream<FriendRequestState> _mapToState(
      Stream<FriendRequestState> Function() yieldCode) async* {
    yield FriendRequestsLoading(requests: _cachedRequests);
    try {
      yield* yieldCode();
    } catch (exception) {
      if (exception is TimeoutException)
        yield FriendRequestsError(message: timeoutExceptionMessage);
      else
        yield FriendRequestsError(message: defaultErrorMessage);
    }
  }

  Stream<FriendRequestState> _fetchFriendsRequests() async* {
    try {
      List<User> requests = await friendRepository.fetchFriendInvitationList();
      _cachedRequests = requests;
      yield FriendRequestsFetched(requests: requests);
    } catch (exception) {
      if (exception is TimeoutException)
        yield FriendRequestsError(message: timeoutExceptionMessage);
      else
        yield FriendRequestsError(message: defaultErrorMessage);
    }
  }
}
