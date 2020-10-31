part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatMessagesFetched extends ChatState {
  final List<ChatMessage> messages;

  ChatMessagesFetched({@required this.messages});

  @override
  List<Object> get props => super.props..addAll(messages);
}

class NewChatMessage extends ChatState {
  final ChatMessage message;

  NewChatMessage({@required this.message});

  @override
  List<Object> get props => super.props..add(message);
}

class ChatError extends ChatState {
  final String message;

  ChatError({@required this.message});

  @override
  List<Object> get props => super.props..add(message);
}
