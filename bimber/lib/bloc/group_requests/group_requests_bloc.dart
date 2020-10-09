import 'dart:async';

import 'package:bimber/models/group.dart';
import 'package:bimber/resources/group_repository.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'group_requests_state.dart';
part 'group_requests_event.dart';

class GroupRequestsBloc extends Bloc<GroupRequestsEvent, GroupRequestState> {
  final GroupRepository groupRepository;
  List<Group> _cachedRequests;

  GroupRequestsBloc({@required this.groupRepository})
      : super(GroupRequestsInitial());

  @override
  Stream<GroupRequestState> mapEventToState(
    GroupRequestsEvent event,
  ) async* {
    if (event is InitGroupRequests) {
      yield* _fetchFriendsRequests();
    }
    if (event is RefetchGroupRequests) {
      yield* _mapRefreshGroupRequestsToState(event);
    }
    if (event is DeclineGroupRequest) {
      yield* _mapToState(() async* {
        bool canceledGroup =
            await groupRepository.cancelGroupInvitation(event.groupId);
        List<Group> requests = await groupRepository.fetchGroupInvitationList();
        _cachedRequests = requests;
        yield canceledGroup
            ? GroupRequestDeclineSuccess(requests: requests)
            : GroupRequestDeclineError(requests: requests);
      });
    }
    if (event is AcceptGroupRequest) {
      yield* _mapToState(() async* {
        bool acceptedGroup =
            await groupRepository.acceptGroupInvitation(event.groupId);
        List<Group> requests = await groupRepository.fetchGroupInvitationList();
        _cachedRequests = requests;
        yield acceptedGroup
            ? GroupRequestAcceptSuccess(requests: requests)
            : GroupRequestAcceptError(requests: requests);
      });
    }
  }

  Stream<GroupRequestState> _mapRefreshGroupRequestsToState(
      RefetchGroupRequests event) async* {
    yield GroupRequestsLoading(requests: _cachedRequests);
    yield* _fetchFriendsRequests();
  }

  Stream<GroupRequestState> _mapToState(
      Stream<GroupRequestState> Function() yieldCode) async* {
    yield GroupRequestsLoading(requests: _cachedRequests);
    try {
      yield* yieldCode();
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupRequestsError(message: timeoutExceptionMessage);
      else
        yield GroupRequestsError(message: defaultErrorMessage);
    }
  }

  Stream<GroupRequestState> _fetchFriendsRequests() async* {
    try {
      List<Group> requests = await groupRepository.fetchGroupInvitationList();
      _cachedRequests = requests;
      yield GroupRequestsFetched(requests: requests);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupRequestsError(message: timeoutExceptionMessage);
      else
        yield GroupRequestsError(message: defaultErrorMessage);
    }
  }
}
