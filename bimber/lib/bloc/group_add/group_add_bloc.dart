import 'dart:async';
import 'package:bimber/models/group.dart';
import 'package:bimber/resources/group_repository.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'group_add_state.dart';
part 'group_add_event.dart';

class GroupAddBloc extends Bloc<GroupAddEvent, GroupAddState> {
  final GroupRepository groupRepository;
  List<Group> _cachedGroups;

  GroupAddBloc({@required this.groupRepository}) : super(GroupAddInitial());

  @override
  Stream<GroupAddState> mapEventToState(
    GroupAddEvent event,
  ) async* {
    if (event is InitGroupAdd) {
      yield* _mapInitGroupAddToState();
    }
    if (event is AddToGroup) {
      yield* _mapAddToGroupToState(event.groupsIds);
    }
  }

  Stream<GroupAddState> _mapAddToGroupToState(List<String> groupsIds) async* {
    yield GroupAddLoading(groups: _cachedGroups);
    try {
      bool result;
      for (String id in groupsIds) {
        result = await groupRepository.addToGroup(id);
        if (!result) break;
      }
      List<Group> groups = await groupRepository.fetchGroupList();
      _cachedGroups = groups;
      yield result
          ? AddToGroupsSuccess(groups: groups)
          : AddToGroupFailure(groups: groups);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupAddError(message: timeoutExceptionMessage);
      else
        yield GroupAddError(message: defaultErrorMessage);
    }
  }

  Stream<GroupAddState> _mapInitGroupAddToState() async* {
    try {
      List<Group> groups = await groupRepository.fetchGroupList();
      _cachedGroups = groups;
      yield GroupAddFetched(groups: groups);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupAddError(message: timeoutExceptionMessage);
      else
        yield GroupAddError(message: defaultErrorMessage);
    }
  }
}
