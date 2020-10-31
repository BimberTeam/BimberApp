import 'dart:async';
import 'package:bimber/models/group.dart';
import 'package:bimber/resources/repositories/repositories.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'chat_info_event.dart';

part 'chat_info_state.dart';

class ChatInfoBloc extends Bloc<ChatInfoEvent, ChatInfoState> {
  final FriendRepository friendRepository;
  final GroupRepository groupRepository;
  final AccountRepository accountRepository;
  final String groupId;

  ChatInfoBloc({@required this.friendRepository, @required this.groupRepository, @required this.accountRepository, @required this.groupId})
      : super(ChatInfoInitial());

  @override
  Stream<ChatInfoState> mapEventToState(
      ChatInfoEvent event,
      ) async* {
    if (event is InitChatInfo) {
      yield* _mapInitChatInfoToState(event);
    }
    if (event is AddMemberToFriends) {
      yield* _mapAddMemberToFriendsToState(event);
    }
  }

  Stream<ChatInfoState> _mapAddMemberToFriendsToState(AddMemberToFriends event) async* {
    try {
      yield ChatInfoLoading();
      bool addedFriends = await friendRepository.deleteFriend(event.id);
      yield addedFriends
          ? ChatInfoAddSuccess()
          : ChatInfoAddFailure();
      Group group = await groupRepository.fetchGroup(groupId);
      List<String> canBeAdded = await friendRepository.checkIfCanBeAddedToFriend(group.members.map((e) => e.id));
      String currentUserId = (await accountRepository.fetchMe()).id;
      yield ChatInfoFetched(group: group, canBeAdded: canBeAdded, currentUserId: currentUserId);
    } catch (exception) {
      if (exception is TimeoutException)
        yield ChatInfoError(message: timeoutExceptionMessage);
      else
        yield ChatInfoError(message: defaultErrorMessage);
    }
  }

  Stream<ChatInfoState> _mapInitChatInfoToState(InitChatInfo event) async* {
    try {
      Group group = await groupRepository.fetchGroup(groupId);
      List<String> canBeAdded = await friendRepository.checkIfCanBeAddedToFriend(group.members.map((e) => e.id));
      String currentUserId = (await accountRepository.fetchMe()).id;
      yield ChatInfoFetched(group: group, canBeAdded: canBeAdded, currentUserId: currentUserId);
    } catch (exception) {
      if (exception is TimeoutException)
        yield ChatInfoError(message: timeoutExceptionMessage);
      else
        yield ChatInfoError(message: defaultErrorMessage);
    }
  }
  
}
