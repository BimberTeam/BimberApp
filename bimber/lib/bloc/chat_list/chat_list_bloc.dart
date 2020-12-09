import 'dart:async';
import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/status.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/repositories/chat_repository.dart';
import 'package:bimber/resources/repositories/repositories.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository chatRepository;
  final FriendRepository friendRepository;
  final GroupRepository groupRepository;
  final AccountRepository accountRepository;

  ChatListBloc(
      {@required this.friendRepository,
      @required this.chatRepository,
      @required this.groupRepository,
      @required this.accountRepository})
      : super(ChatListInitial());

  @override
  Stream<ChatListState> mapEventToState(
    ChatListEvent event,
  ) async* {
    if (event is InitChatList) {
      yield* _fetchChatList();
    }
    if (event is RefreshChatList) {
      yield ChatListLoading();
      yield* _fetchChatList();
    }
    if (event is DeleteFriend) {
      yield* _mapDeleteFriendToState(event);
    }
  }

  Stream<ChatListState> _mapDeleteFriendToState(DeleteFriend event) async* {
    try {
      yield ChatListLoading();
      final message = await friendRepository.deleteFriend(event.friendId);
      if (message.status == Status.OK)
        yield ChatListDeleteSuccess();
      else
        yield ChatListDeleteFailure();
      yield* _fetchChatList();
    } catch (exception) {
      yield* _handleExceptions(exception);
    }
  }

  Stream<ChatListState> _fetchChatList() async* {
    try {
      List<User> friends = await friendRepository.fetchFriendsList();
      List<ChatThumbnail> chats = await chatRepository.fetchChatThumbnails();
      final meId = (await accountRepository.fetchMe()).id;
      bool newInvitations =
          (await friendRepository.fetchFriendInvitationList()).isNotEmpty ||
              (await groupRepository.fetchGroupInvitationList()).isNotEmpty;
      sortChatThumbnails(chats);
      yield ChatListFetched(
          friends: friends,
          chatThumbnails: chats,
          newInvitations: newInvitations,
          meId: meId);
    } catch (exception) {
      yield* _handleExceptions(exception);
    }
  }

  Stream<ChatListState> _handleExceptions(exception) async* {
    if (exception is TimeoutException)
      yield ChatListError(message: timeoutExceptionMessage);
    else
      yield ChatListError(message: defaultErrorMessage);
  }

  List<ChatThumbnail> sortChatThumbnails(List<ChatThumbnail> chats) {
    //sorts chats with following rules:
    // 1. Chat thumbnails without any messages are placed first
    // 2. Chat thumbnails with most recent messages are placed first
    chats.sort((a, b) {
      if (a.lastMessage == null) {
        return -1;
      } else if (b.lastMessage == null) {
        return 1;
      } else if (a.lastMessage.date.isAfter(b.lastMessage.date)) {
        return -1;
      }
      return 1;
    });
    return chats;
  }
}
