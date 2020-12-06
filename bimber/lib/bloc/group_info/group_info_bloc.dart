import 'dart:async';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/status.dart';
import 'package:bimber/resources/repositories/repositories.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'group_info_event.dart';

part 'group_info_state.dart';

class GroupInfoBloc extends Bloc<GroupInfoEvent, GroupInfoState> {
  final FriendRepository friendRepository;
  final GroupRepository groupRepository;
  final AccountRepository accountRepository;
  final String groupId;

  GroupInfoBloc(
      {@required this.friendRepository,
      @required this.groupRepository,
      @required this.accountRepository,
      @required this.groupId})
      : super(GroupInfoInitial());

  @override
  Stream<GroupInfoState> mapEventToState(
    GroupInfoEvent event,
  ) async* {
    if (event is InitGroupInfo) {
      yield* _mapToState();
    }
    if (event is AddMemberToFriends) {
      yield* _mapAddMemberToFriendsToState(event);
    }
    if (event is RefreshGroupInfo) {
      yield GroupInfoLoading();
      yield* _mapToState();
    }
  }

  Stream<GroupInfoState> _mapAddMemberToFriendsToState(
      AddMemberToFriends event) async* {
    try {
      yield GroupInfoLoading();
      final message = await friendRepository.addFriend(event.id);
      if (message.status == Status.OK)
        yield GroupInfoAddSuccess();
      else
        yield GroupInfoAddFailure();
      yield* _mapToState();
    } catch (exception) {
      if (exception is TimeoutException)
        yield GroupInfoError(message: timeoutExceptionMessage);
      else
        yield GroupInfoError(message: defaultErrorMessage);
    }
  }

  Stream<GroupInfoState> _mapToState() async* {
    try {
      final group = await groupRepository.fetchGroup(groupId);
      final friendCandidates =
          (await friendRepository.fetchFriendCandidatesFromGroup(groupId))
              .map((user) => user.id)
              .toList();
      final meId = (await accountRepository.fetchMe()).id;
      final endTime = await groupRepository.fetchGroupTTL(groupId);
      yield GroupInfoFetched(
          group: group,
          friendCandidates: friendCandidates,
          meId: meId,
          endTime: endTime);
    } catch (exception) {
      print(exception);
      if (exception is TimeoutException)
        yield GroupInfoError(message: timeoutExceptionMessage);
      else
        yield GroupInfoError(message: defaultErrorMessage);
    }
  }
}
