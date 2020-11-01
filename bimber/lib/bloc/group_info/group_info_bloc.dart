import 'dart:async';
import 'package:bimber/models/group.dart';
import 'package:bimber/resources/repositories/repositories.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
  }

  Stream<GroupInfoState> _mapAddMemberToFriendsToState(
      AddMemberToFriends event) async* {
    try {
      yield GroupInfoLoading();
      bool addedFriend = await friendRepository.addFriend(event.id);
      yield addedFriend ? GroupInfoAddSuccess() : GroupInfoAddFailure();
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
      final friendsCandidates =
          await groupRepository.fetchFriendCandidates(groupId);
      final meId = (await accountRepository.fetchMe()).id;
      yield GroupInfoFetched(
          group: group, friendsCandidate: friendsCandidates, meId: meId);
    } catch (exception) {
      print(exception);
      if (exception is TimeoutException)
        yield GroupInfoError(message: timeoutExceptionMessage);
      else
        yield GroupInfoError(message: defaultErrorMessage);
    }
  }
}
