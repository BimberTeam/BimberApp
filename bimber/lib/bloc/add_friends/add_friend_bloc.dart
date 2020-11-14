import 'dart:async';
import 'package:bimber/models/status.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'add_friends_state.dart';
part 'add_friends_event.dart';

class AddFriendsBloc extends Bloc<AddFriendsEvent, AddFriendsState> {
  final GroupRepository groupRepository;
  final FriendRepository friendRepository;
  final String groupId;

  AddFriendsBloc(
      {@required this.groupRepository,
      @required this.groupId,
      @required this.friendRepository})
      : super(AddFriendsInitial());

  @override
  Stream<AddFriendsState> mapEventToState(
    AddFriendsEvent event,
  ) async* {
    if (event is InitAddFriends) {
      yield* _mapInitAddFriendsToState();
    }
    if (event is AddFriendsToGroup) {
      yield* _mapAddFriendsToGroupToState(event.memberIds);
    }
  }

  Stream<AddFriendsState> _mapAddFriendsToGroupToState(
      List<String> memberIds) async* {
    try {
      yield AddFriendsLoading();
      for (String memberId in memberIds) {
        final message = await groupRepository.addToGroup(memberId, groupId);
        if (message.status == Status.ERROR) {
          yield AddFriendsFailure(message: message.message);
          List<User> possibleMembers = await friendRepository
              .fetchFriendsWithoutGroupMembership(groupId);
          yield AddFriendsFetched(possibleMembers: possibleMembers);
          return;
        }
      }
      yield AddFriendsSuccess();
      List<User> possibleMembers =
          await friendRepository.fetchFriendsWithoutGroupMembership(groupId);
      yield AddFriendsFetched(possibleMembers: possibleMembers);
    } catch (exception) {
      if (exception is TimeoutException)
        yield AddFriendsError(message: timeoutExceptionMessage);
      else
        yield AddFriendsError(message: defaultErrorMessage);
    }
  }

  Stream<AddFriendsState> _mapInitAddFriendsToState() async* {
    try {
      List<User> possibleMembers =
          await friendRepository.fetchFriendsWithoutGroupMembership(groupId);
      yield AddFriendsFetched(possibleMembers: possibleMembers);
    } catch (exception) {
      if (exception is TimeoutException)
        yield AddFriendsError(message: timeoutExceptionMessage);
      else
        yield AddFriendsError(message: defaultErrorMessage);
    }
  }
}
