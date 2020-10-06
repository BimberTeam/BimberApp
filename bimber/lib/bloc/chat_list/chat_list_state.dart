part of 'chat_list_bloc.dart';

abstract class ChatListResources{
  List<User> getFriends();
  List<ChatThumbnail> getChats();
}

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

class ChatListFetched extends ChatListState implements ChatListResources{
  final List<User> friends;
  final List<ChatThumbnail> chats;

  ChatListFetched({@required this.friends, @required this.chats});

  @override
  List<Object> get props => [friends, chats];

  @override
  List<ChatThumbnail> getChats() {
    return chats;
  }

  @override
  List<User> getFriends() {
    return friends;
  }
}

class ChatListLoading extends ChatListState implements ChatListResources{
  final List<User> friends;
  final List<ChatThumbnail> chats;

  ChatListLoading({@required this.friends, @required this.chats});

  @override
  List<Object> get props => [friends, chats];

  @override
  List<ChatThumbnail> getChats() {
    return chats;
  }

  @override
  List<User> getFriends() {
    return friends;
  }
}

class ChatListDeleteSuccess extends ChatListState implements ChatListResources{
  final List<User> friends;
  final List<ChatThumbnail> chats;

  ChatListDeleteSuccess({@required this.friends, @required this.chats});

  @override
  List<Object> get props => [friends, chats];

  @override
  List<ChatThumbnail> getChats() {
    return chats;
  }

  @override
  List<User> getFriends() {
    return friends;
  }
}

class ChatListDeleteFailure extends ChatListState implements ChatListResources{
  final List<User> friends;
  final List<ChatThumbnail> chats;

  ChatListDeleteFailure({@required this.friends, @required this.chats});

  @override
  List<Object> get props => [friends, chats];

  @override
  List<ChatThumbnail> getChats() {
    return chats;
  }

  @override
  List<User> getFriends() {
    return friends;
  }
}
