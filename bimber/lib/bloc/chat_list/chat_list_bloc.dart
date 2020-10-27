import 'dart:async';
import 'package:bimber/models/chat_thumbnail.dart';
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

  ChatListBloc({@required this.friendRepository, @required this.chatRepository})
      : super(ChatListInitial());

  @override
  Stream<ChatListState> mapEventToState(
    ChatListEvent event,
  ) async* {
    if (event is InitChatList) {
      yield* _initChatList();
    }
    if (event is RefreshChatList) {
      yield* _mapRefreshChatListToState(event);
    }
    if (event is DeleteFriend) {
      yield* _mapDeleteFriendToState(event);
    }
  }

  Stream<ChatListState> _mapRefreshChatListToState(
      RefreshChatList event) async* {
    try {
      yield ChatListLoading(
          friends: await friendRepository.fetchFriendsList(fetchCache: true),
          chatThumbnails:
              await chatRepository.fetchChatThumbnails(fetchCache: true));
      List<User> friends = await friendRepository.fetchFriendsList();
      List<ChatThumbnail> chats = await chatRepository.fetchChatThumbnails();
      sortChatThumbnails(chats);
      yield ChatListFetched(friends: friends, chatThumbnails: chats);
    } catch (exception) {
      yield* _handleExceptions(exception);
    }
  }

  Stream<ChatListState> _mapDeleteFriendToState(DeleteFriend event) async* {
    yield ChatListLoading(
        friends: await friendRepository.fetchFriendsList(fetchCache: true),
        chatThumbnails:
            await chatRepository.fetchChatThumbnails(fetchCache: true));
    try {
      bool deletedFriends = await friendRepository.deleteFriend(event.friendId);
      List<User> friends = await friendRepository.fetchFriendsList();
      List<ChatThumbnail> chats = await chatRepository.fetchChatThumbnails();
      sortChatThumbnails(chats);
      yield deletedFriends
          ? ChatListDeleteSuccess(friends: friends, chatThumbnails: chats)
          : ChatListDeleteFailure(friends: friends, chatThumbnails: chats);
    } catch (exception) {
      yield* _handleExceptions(exception);
    }
  }

  Stream<ChatListState> _initChatList() async* {
    try {
      List<User> friends = await friendRepository.fetchFriendsList();
      List<ChatThumbnail> chats = await chatRepository.fetchChatThumbnails();
      sortChatThumbnails(chats);
      yield ChatListFetched(friends: friends, chatThumbnails: chats);
    } catch (exception) {
      yield* _handleExceptions(exception);
    }
  }

  Stream<ChatListState> _handleExceptions(Exception exception) async* {
    if (exception is TimeoutException)
      yield ChatListError(message: timeoutExceptionMessage);
    else
      yield ChatListError(message: defaultErrorMessage);
  }

  void sortChatThumbnails(List<ChatThumbnail> chats) {
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
  }
}
