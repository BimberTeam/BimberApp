part of 'chat_list_bloc.dart';

@immutable
abstract class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitChatList extends ChatListEvent {}

class RefreshChatList extends ChatListEvent {
  final List<User> friends;
  final List<Chat> chats;

  RefreshChatList({@required this.friends, @required this.chats});

  @override
  List<Object> get props => [friends, chats];
}

class DeleteFriend extends ChatListEvent {
  final List<User> friends;
  final List<Chat> chats;
  final String friendId;

  DeleteFriend({@required this.friends, @required this.chats, @required this.friendId});

  @override
  List<Object> get props => [friends, chats, friendId];
}
