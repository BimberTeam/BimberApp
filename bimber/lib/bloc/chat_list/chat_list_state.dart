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
  final List<ChatThumbnail> chatThumbnails;
  final bool newInvitations;

  ChatListFetched(
      {@required this.friends,
      @required this.chatThumbnails,
      @required this.newInvitations});

  @override
  List<Object> get props => [friends, chatThumbnails, newInvitations];
}

class ChatListLoading extends ChatListState {}

class ChatListDeleteSuccess extends ChatListState {}

class ChatListDeleteFailure extends ChatListState {}
