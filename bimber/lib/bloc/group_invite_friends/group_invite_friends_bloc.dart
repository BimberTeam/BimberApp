import 'dart:async';
import 'package:bimber/models/status.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/friend_repository.dart';
import 'package:bimber/resources/repositories/group_repository.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'group_invite_friends_state.dart';
part 'group_invite_friends_event.dart';

class GroupInviteFriendsBloc
    extends Bloc<GroupInviteFriendsEvent, GroupInviteFriendsState> {
  final GroupRepository groupRepository;
  final FriendRepository friendRepository;
  final String groupId;

  GroupInviteFriendsBloc(
      {@required this.groupRepository,
      @required this.groupId,
      @required this.friendRepository})
      : super(GroupInviteFriendsInitial());

  @override
  Stream<GroupInviteFriendsState> mapEventToState(
    GroupInviteFriendsEvent event,
  ) async* {
    if (event is InitGroupInviteFriends) {
      yield* _mapInitAddFriendsToState();
    }
    if (event is InviteFriendsToGroup) {
      yield* _mapAddFriendsToGroupToState(event.memberIds);
    }
  }

  Stream<GroupInviteFriendsState> _mapAddFriendsToGroupToState(
      List<String> memberIds) async* {
    try {
      yield GroupInviteFriendsLoading();
      for (String memberId in memberIds) {
        final message = await groupRepository.addToGroup(memberId, groupId);
        if (message.status == Status.ERROR) {
          yield GroupInviteFriendsFailure(message: message.message);
          List<User> possibleMembers = await friendRepository
              .fetchFriendsWithoutGroupMembership(groupId);
          yield GroupInviteFriendsFetched(possibleMembers: possibleMembers);
          return;
        }
      }
      yield GroupInviteFriendsSuccess();
      List<User> possibleMembers =
          await friendRepository.fetchFriendsWithoutGroupMembership(groupId);
      yield GroupInviteFriendsFetched(possibleMembers: possibleMembers);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupInviteFriendsError(message: timeoutExceptionMessage);
      else
        yield GroupInviteFriendsError(message: defaultErrorMessage);
    }
  }

  Stream<GroupInviteFriendsState> _mapInitAddFriendsToState() async* {
    try {
      List<User> possibleMembers =
          await friendRepository.fetchFriendsWithoutGroupMembership(groupId);
      yield GroupInviteFriendsFetched(possibleMembers: possibleMembers);
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupInviteFriendsError(message: timeoutExceptionMessage);
      else
        yield GroupInviteFriendsError(message: defaultErrorMessage);
    }
  }
}
