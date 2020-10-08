import 'dart:async';

import 'package:bimber/models/group.dart';
import 'package:bimber/resources/group_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'group_requests_state.dart';
part 'group_requests_event.dart';

class GroupRequestsBloc extends Bloc<GroupRequestsEvent, GroupRequestsState> {
  final GroupRepository groupRepository;
  List<Group> _cachedRequests;

  GroupRequestsBloc({@required this.groupRepository})
      : super(GroupRequestsInitial());

  @override
  Stream<GroupRequestsState> mapEventToState(
      GroupRequestsEvent event,
      ) async* {
    if (event is InitGroupRequests) {
      yield* _mapInitGroupRequestsToState(event);
    }
    if (event is RefreshGroupRequests) {
      yield* _mapRefreshGroupRequestsToState(event);
    }
    if (event is CancelGroupInvitation) {
      yield* _mapCancelFriendToState(event);
    }
    if(event is AcceptGroupInvitation){
      yield* _mapAcceptFriendToState(event);
    }
  }

  Stream<GroupRequestsState> _mapInitGroupRequestsToState(InitGroupRequests event) async* {
    yield* _fetchFriendsRequests();
  }

  Stream<GroupRequestsState> _mapRefreshGroupRequestsToState(
      RefreshGroupRequests event) async* {
    yield GroupRequestsLoading(requests: _cachedRequests);
    yield* _fetchFriendsRequests();
  }

  Stream<GroupRequestsState> _mapCancelFriendToState(CancelGroupInvitation event) async* {
    yield GroupRequestsLoading(requests: _cachedRequests);
    try {
      bool canceledGroup = await groupRepository.cancelGroupInvitation(event.groupId);
      List<Group> requests = await groupRepository.fetchGroupInvitationList();
      _cachedRequests = requests;
      yield canceledGroup
          ? GroupRequestsCancelSuccess(requests: requests)
          : GroupRequestsCancelError(requests: requests);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupRequestsError(
            message:
            "Serwer nie odpowiada, sprawdź swoję połączenię internetowe i spróbuj ponownie.");
      else
        yield GroupRequestsError(
            message:
            "Coś poszło nie tak, pracujemy nad rozwiązaniem problemu.");
    }
  }

  Stream<GroupRequestsState> _mapAcceptFriendToState(AcceptGroupInvitation event) async* {
    yield GroupRequestsLoading(requests: _cachedRequests);
    try {
      bool acceptedGroup = await groupRepository.acceptGroupInvitation(event.groupId);
      List<Group> requests = await groupRepository.fetchGroupInvitationList();
      _cachedRequests = requests;
      yield acceptedGroup
          ? GroupRequestsAcceptSuccess(requests: requests)
          : GroupRequestsAcceptError(requests: requests);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupRequestsError(
            message:
            "Serwer nie odpowiada, sprawdź swoję połączenię internetowe i spróbuj ponownie.");
      else
        yield GroupRequestsError(
            message:
            "Coś poszło nie tak, pracujemy nad rozwiązaniem problemu.");
    }
  }

  Stream<GroupRequestsState> _fetchFriendsRequests() async* {
    try {
      List<Group> requests = await groupRepository.fetchGroupInvitationList();
      _cachedRequests = requests;
      yield GroupRequestsFetched(requests: requests);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupRequestsError(
            message:
            "Serwer nie odpowiada, sprawdź swoję połączenię internetowe i spróbuj ponownie.");
      else
        yield GroupRequestsError(
            message:
            "Coś poszło nie tak, pracujemy nad rozwiązaniem problemu.");
    }
  }

}