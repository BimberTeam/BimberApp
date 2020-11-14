import 'dart:async';

import 'package:bimber/models/group.dart';
import 'package:bimber/models/status.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'group_requests_state.dart';
part 'group_requests_event.dart';

class GroupRequestsBloc extends Bloc<GroupRequestsEvent, GroupRequestState> {
  final GroupRepository groupRepository;

  GroupRequestsBloc({@required this.groupRepository})
      : super(GroupRequestsInitial());

  @override
  Stream<GroupRequestState> mapEventToState(
    GroupRequestsEvent event,
  ) async* {
    if (event is InitGroupRequests) {
      yield* _initFriendsRequests();
    }
    if (event is RefetchGroupRequests) {
      yield* _mapRefreshGroupRequestsToState(event);
    }
    if (event is DeclineGroupRequest) {
      yield* _mapDeclineGroupRequestToState(event);
    }
    if (event is AcceptGroupRequest) {
      yield* _mapAcceptGroupRequestToState(event);
    }
  }

  Stream<GroupRequestState> _mapRefreshGroupRequestsToState(
      RefetchGroupRequests event) async* {
    try {
      yield GroupRequestsLoading(
          requests:
              await groupRepository.fetchGroupInvitationList(fetchCache: true));
      List<Group> requests = await groupRepository.fetchGroupInvitationList();
      yield GroupRequestsFetched(requests: requests);
    } catch (exception) {
      yield* _handleException(exception);
    }
  }

  Stream<GroupRequestState> _mapDeclineGroupRequestToState(
      DeclineGroupRequest event) async* {
    try {
      yield GroupRequestsLoading(
          requests:
              await groupRepository.fetchGroupInvitationList(fetchCache: true));
      final message =
          await groupRepository.cancelGroupInvitation(event.groupId);
      List<Group> requests = await groupRepository.fetchGroupInvitationList();
      if (message.status == Status.OK)
        yield GroupRequestDeclineSuccess(requests: requests);
      else
        yield GroupRequestDeclineError(requests: requests);
    } catch (exception) {
      yield* _handleException(exception);
    }
  }

  Stream<GroupRequestState> _mapAcceptGroupRequestToState(
      AcceptGroupRequest event) async* {
    try {
      yield GroupRequestsLoading(
          requests:
              await groupRepository.fetchGroupInvitationList(fetchCache: true));
      final message =
          await groupRepository.acceptGroupInvitation(event.groupId);
      List<Group> requests = await groupRepository.fetchGroupInvitationList();
      if (message.status == Status.OK)
        yield GroupRequestAcceptSuccess(requests: requests);
      else
        yield GroupRequestAcceptError(requests: requests);
    } catch (exception) {
      yield* _handleException(exception);
    }
  }

  Stream<GroupRequestState> _initFriendsRequests() async* {
    try {
      List<Group> requests = await groupRepository.fetchGroupInvitationList();
      yield GroupRequestsFetched(requests: requests);
    } catch (exception) {
      yield* _handleException(exception);
    }
  }

  Stream<GroupRequestState> _handleException(exception) async* {
    if (exception is TimeoutException)
      yield GroupRequestsError(message: timeoutExceptionMessage);
    else
      yield GroupRequestsError(message: defaultErrorMessage);
  }
}
