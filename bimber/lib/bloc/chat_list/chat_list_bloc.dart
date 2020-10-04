import 'dart:async';
import 'package:bimber/models/chat.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/chat_repositry.dart';
import 'package:bimber/resources/friend_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository chatRepository;
  final FriendRepository friendRepository;
  List<User> cachedFriends;
  List<Chat> cachedChats;

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
    try {
      List<User> friends = await friendRepository.fetchFriendsList();
      List<Chat> chats = await chatRepository.fetchChatList();
      chats.sort((a, b) {
        if (a.lastMessage == null)
          return -1;
        else if (b.lastMessage == null)
          return 1;
        else if (a.lastMessage.date.isAfter(b.lastMessage.date)) return -1;
        return 1;
      });
      cachedChats = chats;
      cachedFriends = friends;
      yield ChatListFetched(friends: friends, chats: chats);
    } catch (exception) {
      yield ChatListError(message: "some error");
    }
  }

  Stream<ChatListState> _mapRefreshChatListToState(
      RefreshChatList event) async* {
    yield ChatListLoading(friends: cachedFriends, chats: cachedChats);
    try {
      List<User> friends = await friendRepository.fetchFriendsList();
      List<Chat> chats = await chatRepository.fetchChatList();
      chats.sort((a, b) {
        if (a.lastMessage == null)
          return -1;
        else if (b.lastMessage == null)
          return 1;
        else if (a.lastMessage.date.isAfter(b.lastMessage.date)) return -1;
        return 1;
      });
      cachedChats = chats;
      cachedFriends = friends;
      yield ChatListFetched(friends: friends, chats: chats);
    } catch (exception) {
      yield ChatListError(message: "some error");
    }
  }

  Stream<ChatListState> _mapDeleteFriendToState(DeleteFriend event) async* {
    yield ChatListLoading(friends: cachedFriends, chats: cachedChats);
    try {
      bool result = await friendRepository.deleteFriend(event.friendId);
      List<User> friends = await friendRepository.fetchFriendsList();
      List<Chat> chats = await chatRepository.fetchChatList();
      chats.sort((a, b) {
        if (a.lastMessage == null)
          return -1;
        else if (b.lastMessage == null)
          return 1;
        else if (a.lastMessage.date.isAfter(b.lastMessage.date)) return -1;
        return 1;
      });
      cachedChats = chats;
      cachedFriends = friends;
      yield result
          ? ChatListDeleteSuccess(friends: friends, chats: chats)
          : ChatListDeleteFailure(friends: friends, chats: chats);
    } catch (exception) {
      yield ChatListError(message: "some error");
    }
  }
}
