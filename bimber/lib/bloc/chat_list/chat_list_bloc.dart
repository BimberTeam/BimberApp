import 'dart:async';
import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/user.dart';
import 'package:bimber/resources/chat_repositry.dart';
import 'package:bimber/resources/friend_repository.dart';
import 'package:bimber/ui/common/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository chatRepository;
  final FriendRepository friendRepository;
  List<User> _cachedFriends;
  List<ChatThumbnail> _cachedChats;

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
    yield ChatListLoading(friends: _cachedFriends, chats: _cachedChats);
    yield* _fetchFriendsAndChats();
  }

  Stream<ChatListState> _mapDeleteFriendToState(DeleteFriend event) async* {
    yield ChatListLoading(friends: _cachedFriends, chats: _cachedChats);
    try {
      bool deletedFriends = await friendRepository.deleteFriend(event.friendId);
      List<User> friends = await friendRepository.fetchFriendsList();
      List<ChatThumbnail> chats = await chatRepository.fetchChatList();
      sortChats(chats);
      _cachedChats = chats;
      _cachedFriends = friends;
      yield deletedFriends
          ? ChatListDeleteSuccess(friends: friends, chats: chats)
          : ChatListDeleteFailure(friends: friends, chats: chats);
    } catch (exception) {
      if (exception is TimeoutException)
        yield ChatListError(
            message:
                "Serwer nie odpowiada, sprawdź swoję połączenię internetowe i spróbuj ponownie.");
      else
        yield ChatListError(
            message:
                "Coś poszło nie tak, pracujemy nad rozwiązaniem problemu.");
    }
  }

  Stream<ChatListState> _fetchFriendsAndChats() async* {
    try {
      List<User> friends = await friendRepository.fetchFriendsList();
      List<ChatThumbnail> chats = await chatRepository.fetchChatList();
      sortChats(chats);
      _cachedChats = chats;
      _cachedFriends = friends;
      yield ChatListFetched(friends: friends, chats: chats);
    } catch (exception) {
      if (exception is TimeoutException)
        yield ChatListError(
            message:
                "Serwer nie odpowiada, sprawdź swoję połączenię internetowe i spróbuj ponownie.");
      else
        yield ChatListError(
            message:
                "Coś poszło nie tak, pracujemy nad rozwiązaniem problemu.");
    }
  }
}
