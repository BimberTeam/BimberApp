import 'dart:async';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'group_maker_state.dart';
part 'group_maker_event.dart';

class GroupMakerBloc extends Bloc<GroupMakerEvent, GroupMakerState> {
  final GroupRepository groupRepository;
  final FriendRepository friendRepository;

  GroupMakerBloc(
      {@required this.groupRepository, @required this.friendRepository})
      : super(GroupMakerInitial());

  @override
  Stream<GroupMakerState> mapEventToState(
    GroupMakerEvent event,
  ) async* {
    if (event is InitGroupMaker) {
      yield* _mapInitGroupMakerToState();
    }
    if (event is CreateGroup) {
      yield* _mapCreateGroupToState(event.memberIds);
    }
  }

  Stream<GroupMakerState> _mapCreateGroupToState(
      List<String> memberIds) async* {
    try {
      yield GroupMakerLoading(
          friends: await friendRepository.fetchFriendsList(fetchCache: true));
      bool result = await groupRepository.createGroup(memberIds);
      List<User> friends = await friendRepository.fetchFriendsList();
      yield result
          ? GroupMakerSuccess(friends: friends)
          : GroupMakerFailure(friends: friends);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupMakerError(message: timeoutExceptionMessage);
      else
        yield GroupMakerError(message: defaultErrorMessage);
    }
  }

  Stream<GroupMakerState> _mapInitGroupMakerToState() async* {
    try {
      List<User> friends = await friendRepository.fetchFriendsList();
      yield GroupMakerFetched(friends: friends);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupMakerError(message: timeoutExceptionMessage);
      else
        yield GroupMakerError(message: defaultErrorMessage);
    }
  }
}
