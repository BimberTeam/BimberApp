import 'dart:async';
import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/chat_repositry.dart';
import 'package:bimber/resources/friend_repository.dart';
import 'package:bimber/ui/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository chatRepository;
  final FriendRepository friendRepository;
  List<User> _cachedFriends;
  List<ChatThumbnail> _cachedChatThumbnails;

  ChatListBloc({@required this.friendRepository, @required this.chatRepository})
      : super(ChatListInitial());

  @override
  Stream<ChatListState> mapEventToState(
    ChatListEvent event,
  ) async* {
    if (event is InitChatList) {
      yield* _mapInitChatListToState(event);
    }
    if (event is RefreshChatList) {
      yield* _mapRefreshChatListToState(event);
    }
    if (event is DeleteFriend) {
      yield* _mapDeleteFriendToState(event);
    }
  }

  Stream<ChatListState> _mapInitChatListToState(InitChatList event) async* {
    yield* _fetchFriendsAndChats();
  }

  Stream<ChatListState> _mapRefreshChatListToState(
      RefreshChatList event) async* {
    yield ChatListLoading(
        friends: _cachedFriends, chatThumbnails: _cachedChatThumbnails);
    yield* _fetchFriendsAndChats();
  }

  Stream<ChatListState> _mapDeleteFriendToState(DeleteFriend event) async* {
    yield ChatListLoading(
        friends: _cachedFriends, chatThumbnails: _cachedChatThumbnails);
    try {
      bool deletedFriends = await friendRepository.deleteFriend(event.friendId);
      List<User> friends = await friendRepository.fetchFriendsList();
      List<ChatThumbnail> chats = await chatRepository.fetchChatThumbnails();
      sortChatThumbnails(chats);
      _cachedChatThumbnails = chats;
      _cachedFriends = friends;
      yield deletedFriends
          ? ChatListDeleteSuccess(friends: friends, chatThumbnails: chats)
          : ChatListDeleteFailure(friends: friends, chatThumbnails: chats);
    } catch (exception) {
      if (exception is TimeoutException)
        yield ChatListError(message: timeoutExceptionMessage);
      else
        yield ChatListError(message: defaultErrorMessage);
    }
  }

  Stream<ChatListState> _fetchFriendsAndChats() async* {
    try {
      List<User> friends = await friendRepository.fetchFriendsList();
      List<ChatThumbnail> chats = await chatRepository.fetchChatThumbnails();
      sortChatThumbnails(chats);
      _cachedChatThumbnails = chats;
      _cachedFriends = friends;
      yield ChatListFetched(friends: friends, chatThumbnails: chats);
    } catch (exception) {
      if (exception is TimeoutException)
        yield ChatListError(message: timeoutExceptionMessage);
      else
        yield ChatListError(message: defaultErrorMessage);
    }
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
