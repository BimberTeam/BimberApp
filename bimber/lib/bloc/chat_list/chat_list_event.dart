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

class RefreshChatList extends ChatListEvent {}

class DeleteFriend extends ChatListEvent {
  final String friendId;

  DeleteFriend({ @required this.friendId});

  @override
  List<Object> get props => [friendId];
}
