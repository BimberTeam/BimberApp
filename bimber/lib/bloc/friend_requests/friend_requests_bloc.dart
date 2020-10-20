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
      yield* _refetchFriendRequests();
    }
    if (event is DeclineFriendRequest) {
      yield* _mapDeclineFriendRequestToState(event);
    }
    if (event is AcceptFriendRequest) {
      yield* _acceptFriendRequests(event);
    }
  }

  Stream<FriendRequestState> _mapDeclineFriendRequestToState(DeclineFriendRequest event) async* {
    try {
      yield FriendRequestsLoading(
          requests: await friendRepository.fetchFriendInvitationList(
              fetchCache: true));
      bool canceledFriend =
      await friendRepository.declineInvitation(event.friendId);
      List<User> requests =
      await friendRepository.fetchFriendInvitationList();
      yield canceledFriend
          ? FriendRequestsDeclineSuccess(requests: requests)
          : FriendRequestsDeclineError(requests: requests);
    } catch (exception) {
      yield* _handleException(exception);
    }
  }

  Stream<FriendRequestState> _acceptFriendRequests(AcceptFriendRequest event) async* {
    try {
      yield FriendRequestsLoading(
          requests: await friendRepository.fetchFriendInvitationList(
              fetchCache: true));
      bool acceptedFriend =
      await friendRepository.acceptInvitation(event.friendId);
      List<User> requests =
      await friendRepository.fetchFriendInvitationList();
      yield acceptedFriend
          ? FriendRequestsAcceptSuccess(requests: requests)
          : FriendRequestsAcceptError(requests: requests);
    } catch (exception) {
      yield* _handleException(exception);
    }
  }

  Stream<FriendRequestState> _refetchFriendRequests() async* {
    try {
      yield FriendRequestsLoading(
          requests: await friendRepository.fetchFriendInvitationList(
              fetchCache: true));
      List<User> requests = await friendRepository.fetchFriendInvitationList();
      yield FriendRequestsFetched(requests: requests);
    } catch (exception) {
      yield * _handleException(exception);
    }
  }

  Stream<FriendRequestState> _initFriendsRequests() async* {
    try {
      List<User> requests = await friendRepository.fetchFriendInvitationList();
      yield FriendRequestsFetched(requests: requests);
    } catch (exception) {
      yield* _handleException(exception);
    }
  }

  Stream<FriendRequestState> _handleException(Exception exception) async* {
    if (exception is TimeoutException)
      yield FriendRequestsError(message: timeoutExceptionMessage);
    else
      yield FriendRequestsError(message: defaultErrorMessage);
  }
}
