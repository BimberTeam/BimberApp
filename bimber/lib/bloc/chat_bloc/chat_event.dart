part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class FetchChatMessages extends ChatEvent {
  final String groupId;
  final int limit;
  final DateTime lastDate;

  FetchChatMessages(
      {@required this.groupId, int limit = 50, DateTime lastDate = null})
      : limit = limit,
        lastDate = lastDate;

  @override
  List<Object> get props => super.props..addAll([groupId, limit, lastDate]);
}

class SendChatMessage extends ChatEvent {
  final String groupId;
  final String message;

  SendChatMessage({@required this.groupId, @required this.message});

  @override
  List<Object> get props => super.props..addAll([groupId, message]);
}

class DeliverNewChatMessage extends ChatEvent {
  final ChatMessage message;

  DeliverNewChatMessage({@required this.message});

  @override
  List<Object> get props => super.props..add(message);
}
