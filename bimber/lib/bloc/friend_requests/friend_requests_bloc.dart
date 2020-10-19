import 'dart:async';

import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/repositories.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'friend_requests_event.dart';
part 'friend_requests_state.dart';

class FriendRequestBloc extends Bloc<FriendRequestEvent, FriendRequestState> {
  final FriendRepository friendRepository;

  FriendRequestBloc({@required this.friendRepository})
      : super(FriendRequestsInitial());

  @override
  Stream<FriendRequestState> mapEventToState(
    FriendRequestEvent event,
  ) async* {
    if (event is InitFriendRequests) {
      yield* _initFriendsRequests();
    }
    if (event is RefetchFriendRequests) {
      yield* _mapToState(() async* {
        List<User> requests =
            await friendRepository.fetchFriendInvitationList();
        yield FriendRequestsFetched(requests: requests);
      });
    }
    if (event is DeclineFriendRequest) {
      yield* _mapToState(() async* {
        bool canceledFriend =
            await friendRepository.cancelInvitation(event.friendId);
        List<User> requests =
            await friendRepository.fetchFriendInvitationList();
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
        yield acceptedFriend
            ? FriendRequestsAcceptSuccess(requests: requests)
            : FriendRequestsAcceptError(requests: requests);
      });
    }
  }

  Stream<FriendRequestState> _mapToState(
      Stream<FriendRequestState> Function() yieldCode) async* {
    try {
      yield FriendRequestsLoading(
          requests: await friendRepository.fetchFriendInvitationList(
              fetchCache: true));
      yield* yieldCode();
    } catch (exception) {
      if (exception is TimeoutException)
        yield FriendRequestsError(message: timeoutExceptionMessage);
      else
        yield FriendRequestsError(message: defaultErrorMessage);
    }
  }

  Stream<FriendRequestState> _initFriendsRequests() async* {
    try {
      List<User> requests = await friendRepository.fetchFriendInvitationList();
      yield FriendRequestsFetched(requests: requests);
    } catch (exception) {
      if (exception is TimeoutException)
        yield FriendRequestsError(message: timeoutExceptionMessage);
      else
        yield FriendRequestsError(message: defaultErrorMessage);
    }
  }
}
