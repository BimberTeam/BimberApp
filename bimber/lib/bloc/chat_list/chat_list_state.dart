part of 'chat_list_bloc.dart';

@immutable
abstract class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ChatListInitial extends ChatListState {}

class ChatListError extends ChatListState {
  final String message;

  ChatListError({@required this.message});

  @override
  List<Object> get props => [message];
}

class ChatListFetched extends ChatListState {
  final List<User> friends;
  final List<Chat> chats;

  ChatListFetched({@required this.friends, @required this.chats});

  @override
  List<Object> get props => [friends, chats];
}

class ChatListLoading extends ChatListState {
  final List<User> friends;
  final List<Chat> chats;

  ChatListLoading({@required this.friends, @required this.chats});

  @override
  List<Object> get props => [friends, chats];
}

class ChatListDeleteSuccess extends ChatListState {
  final List<User> friends;
  final List<Chat> chats;

  ChatListDeleteSuccess({@required this.friends, @required this.chats});

  @override
  List<Object> get props => [friends, chats];
}

class ChatListDeleteFailure extends ChatListState {
  final List<User> friends;
  final List<Chat> chats;

  ChatListDeleteFailure({@required this.friends, @required this.chats});

  @override
  List<Object> get props => [friends, chats];
}
