part of 'chat_info_bloc.dart';

@immutable
abstract class ChatInfoState extends Equatable {
  const ChatInfoState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ChatInfoInitial extends ChatInfoState {}

class ChatInfoError extends ChatInfoState {
  final String message;

  ChatInfoError({@required this.message});

  @override
  List<Object> get props => [message];
}


class ChatInfoFetched extends ChatInfoState{
  final List<String> canBeAdded;
  final String currentUserId;
  final Group group;

  ChatInfoFetched({this.canBeAdded, this.currentUserId, this.group});

  @override
  List<Object> get props => [this.canBeAdded, this.currentUserId, this.group];
}

class ChatInfoLoading extends ChatInfoState {}

class ChatInfoAddSuccess extends ChatInfoState {}

class ChatInfoAddFailure extends ChatInfoState {}
