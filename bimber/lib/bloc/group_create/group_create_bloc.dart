import 'dart:async';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'group_create_state.dart';
part 'group_create_event.dart';

class GroupCreateBloc extends Bloc<GroupCreateEvent, GroupCreateState> {
  final GroupRepository groupRepository;
  final FriendRepository friendRepository;

  GroupCreateBloc(
      {@required this.groupRepository, @required this.friendRepository})
      : super(GroupCreateInitial());

  @override
  Stream<GroupCreateState> mapEventToState(
    GroupCreateEvent event,
  ) async* {
    if (event is InitGroupCreate) {
      yield* _mapInitGroupCreateToState();
    }
    if (event is CreateGroup) {
      yield* _mapCreateGroupToState(event.memberIds);
    }
  }

  Stream<GroupCreateState> _mapCreateGroupToState(
      List<String> memberIds) async* {
    yield GroupCreateLoading(friends: friendRepository.getCachedFriendsList());
    try {
      bool result = await groupRepository.createGroup(memberIds);
      List<User> friends = await friendRepository.fetchFriendsList();
      yield result
          ? GroupCreateSuccess(friends: friends)
          : GroupCreateFailure(friends: friends);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupCreateError(message: timeoutExceptionMessage);
      else
        yield GroupCreateError(message: defaultErrorMessage);
    }
  }

  Stream<GroupCreateState> _mapInitGroupCreateToState() async* {
    try {
      List<User> friends = await friendRepository.fetchFriendsList();
      yield GroupCreateFetched(friends: friends);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupCreateError(message: timeoutExceptionMessage);
      else
        yield GroupCreateError(message: defaultErrorMessage);
    }
  }
}
