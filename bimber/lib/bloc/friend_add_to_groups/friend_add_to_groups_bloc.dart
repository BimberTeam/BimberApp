import 'dart:async';
import 'package:bimber/models/group.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'friend_add_to_groups_state.dart';
part 'friend_add_to_groups_event.dart';

class AddFriendToGroupsBloc extends Bloc<AddFriendToGroupsEvent, AddFriendToGroupsState> {
  final GroupRepository groupRepository;

  AddFriendToGroupsBloc({@required this.groupRepository}) : super(AddFriendToGroupsInitial());

  @override
  Stream<AddFriendToGroupsState> mapEventToState(
    AddFriendToGroupsEvent event,
  ) async* {
    if (event is InitAddFriendToGroups) {
      yield* _mapInitAddFriendToGroupsToState();
    }
    if (event is AddFriendToGroupSubmit) {
      yield* _mapAddToGroupToState(event.groupsIds);
    }
  }

  Stream<AddFriendToGroupsState> _mapAddToGroupToState(List<String> groupsIds) async* {
    yield AddFriendToGroupsLoading(groups: groupRepository.getCachedGroupList());
    try {
      bool result;
      for (String id in groupsIds) {
        result = await groupRepository.addToGroup(id);
        if (!result) break;
      }
      List<Group> groups = await groupRepository.fetchGroupList();
      yield result
          ? AddFriendToGroupsSuccess(groups: groups)
          : AddFriendToGroupFailure(groups: groups);
    } catch (exception) {
      if (exception is TimeoutException)
        yield AddFriendToGroupsError(message: timeoutExceptionMessage);
      else
        yield AddFriendToGroupsError(message: defaultErrorMessage);
    }
  }

  Stream<AddFriendToGroupsState> _mapInitAddFriendToGroupsToState() async* {
    try {
      List<Group> groups = await groupRepository.fetchGroupList();
      yield AddFriendToGroupsFetched(groups: groups);
    } catch (exception) {
      if (exception is TimeoutException)
        yield AddFriendToGroupsError(message: timeoutExceptionMessage);
      else
        yield AddFriendToGroupsError(message: defaultErrorMessage);
    }
  }
}
