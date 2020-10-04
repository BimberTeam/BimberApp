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

  ChatListBloc({@required this.friendRepository, @required this.chatRepository})
    : super(ChatListInitial());

  @override
  Stream<ChatListState> mapEventToState(
      ChatListEvent event,
      ) async* {
    if (event is InitChatList) {
     _mapChatListInitialToState(event);
    }
    if (event is RefreshChatList) {
      _mapRefreshChatListToState(event);
    }
    if (event is DeleteFriend){
      _mapDeleteFriendToState(event);
    }
  }

  Stream<ChatListState> _mapChatListInitialToState(InitChatList event) async*{
    try{
      List<User> friends = await friendRepository.fetchFriendsList();
      List<Chat> chats =  await chatRepository.fetchChatList();
      chats.sort((a, b) => a.lastMessage.date.isBefore(b.lastMessage.date) ? 1 : -1);
      yield ChatListFetched(friends: friends, chats: chats);
    }catch(exception){
      yield ChatListError(message: "some error");
    }
  }

  Stream<ChatListState> _mapRefreshChatListToState(RefreshChatList event) async*{
    yield ChatListLoading(friends: event.friends, chats: event.chats);
    try{
      List<User> friends = await friendRepository.fetchFriendsList();
      List<Chat> chats =  await chatRepository.fetchChatList();
      chats.sort((a, b) => a.lastMessage.date.isBefore(b.lastMessage.date) ? 1 : -1);
      yield ChatListFetched(friends: friends, chats: chats);
    }catch(exception){
      yield ChatListError(message: "some error");
    }
  }

  Stream<ChatListState> _mapDeleteFriendToState(DeleteFriend event) async*{
    yield ChatListLoading(friends: event.friends, chats: event.chats);
    try{
      bool result = await friendRepository.deleteFriend(event.friendId);
      List<User> friends = await friendRepository.fetchFriendsList();
      List<Chat> chats =  await chatRepository.fetchChatList();
      chats.sort((a, b) => a.lastMessage.date.isBefore(b.lastMessage.date) ? 1 : -1);
      yield result ? ChatListDeleteSuccess(friends: friends, chats: chats) : ChatListDeleteFailure(friends: friends, chats: chats);
    }catch(exception){
      yield ChatListError(message: "some error");
    }
  }
}
