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

class ChatListResources extends ChatListState {
  final List<User> friends;
  final List<ChatThumbnail> chatThumbnails;

  ChatListResources({@required this.friends, @required this.chatThumbnails});

  @override
  List<Object> get props => [friends, chatThumbnails];

  List<ChatThumbnail> getChats() {
    return chatThumbnails;
  }

  List<User> getFriends() {
    return friends;
  }
}

class ChatListFetched extends ChatListResources {
  ChatListFetched({@required friends, @required chatThumbnails})
      : super(friends: friends, chatThumbnails: chatThumbnails);
}

class ChatListLoading extends ChatListResources {
  ChatListLoading({@required friends, @required chatThumbnails})
      : super(friends: friends, chatThumbnails: chatThumbnails);
}

class ChatListDeleteSuccess extends ChatListResources {
  ChatListDeleteSuccess({@required friends, @required chatThumbnails})
      : super(friends: friends, chatThumbnails: chatThumbnails);
}

class ChatListDeleteFailure extends ChatListResources {
  ChatListDeleteFailure({@required friends, @required chatThumbnails})
      : super(friends: friends, chatThumbnails: chatThumbnails);
}
