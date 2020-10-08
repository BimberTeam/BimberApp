import 'dart:async';

import 'package:bimber/models/user.dart';
import 'package:bimber/resources/friend_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'friend_requests_event.dart';
part 'friend_requests_state.dart';

class FriendRequestsBloc extends Bloc<FriendRequestsEvent, FriendRequestsState> {
  final FriendRepository friendRepository;
  List<User> _cachedRequests;

  FriendRequestsBloc({@required this.friendRepository})
      : super(FriendRequestsInitial());

  @override
  Stream<FriendRequestsState> mapEventToState(
      FriendRequestsEvent event,
      ) async* {
    if (event is InitFriendRequests) {
      yield* _mapInitFriendRequestsToState(event);
    }
    if (event is RefreshFriendRequests) {
      yield* _mapRefreshFriendRequestsToState(event);
    }
    if (event is CancelFriend) {
      yield* _mapCancelFriendToState(event);
    }
    if(event is AcceptFriend){
      yield* _mapAcceptFriendToState(event);
    }
  }

  Stream<FriendRequestsState> _mapInitFriendRequestsToState(InitFriendRequests event) async* {
    yield* _fetchFriendsRequests();
  }

  Stream<FriendRequestsState> _mapRefreshFriendRequestsToState(
      RefreshFriendRequests event) async* {
    yield FriendRequestsLoading(requests: _cachedRequests);
    yield* _fetchFriendsRequests();
  }

  Stream<FriendRequestsState> _mapCancelFriendToState(CancelFriend event) async* {
    yield FriendRequestsLoading(requests: _cachedRequests);
    try {
      bool canceledFriend = await friendRepository.cancelInvitation(event.friendId);
      List<User> requests = await friendRepository.fetchFriendInvitationList();
      _cachedRequests = requests;
      yield canceledFriend
          ? FriendRequestsCancelSuccess(requests: requests)
          : FriendRequestsCancelError(requests: requests);
    } catch (exception) {
      if (exception is TimeoutException)
        yield FriendRequestsError(
            message:
            "Serwer nie odpowiada, sprawdź swoję połączenię internetowe i spróbuj ponownie.");
      else
        yield FriendRequestsError(
            message:
            "Coś poszło nie tak, pracujemy nad rozwiązaniem problemu.");
    }
  }

  Stream<FriendRequestsState> _mapAcceptFriendToState(AcceptFriend event) async* {
    yield FriendRequestsLoading(requests: _cachedRequests);
    try {
      bool acceptedFriend = await friendRepository.acceptInvitation(event.friendId);
      List<User> requests = await friendRepository.fetchFriendInvitationList();
      _cachedRequests = requests;
      yield acceptedFriend
          ? FriendRequestsAcceptSuccess(requests: requests)
          : FriendRequestsAcceptError(requests: requests);
    } catch (exception) {
      if (exception is TimeoutException)
        yield FriendRequestsError(
            message:
            "Serwer nie odpowiada, sprawdź swoję połączenię internetowe i spróbuj ponownie.");
      else
        yield FriendRequestsError(
            message:
            "Coś poszło nie tak, pracujemy nad rozwiązaniem problemu.");
    }
  }

  Stream<FriendRequestsState> _fetchFriendsRequests() async* {
    try {
      List<User> requests = await friendRepository.fetchFriendInvitationList();
      _cachedRequests = requests;
      yield FriendRequestsFetched(requests: requests);
    } catch (exception) {
      if (exception is TimeoutException)
        yield FriendRequestsError(
            message:
            "Serwer nie odpowiada, sprawdź swoję połączenię internetowe i spróbuj ponownie.");
      else
        yield FriendRequestsError(
            message:
            "Coś poszło nie tak, pracujemy nad rozwiązaniem problemu.");
    }
  }

}
