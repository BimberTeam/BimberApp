part of 'chat_info_bloc.dart';

@immutable
abstract class ChatInfoEvent extends Equatable {
  const ChatInfoEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitChatInfo extends ChatInfoEvent {}

class AddMemberToFriends extends ChatInfoEvent {
  final String id;

  AddMemberToFriends({@required this.id});

  @override
  List<Object> get props => [id];
}
