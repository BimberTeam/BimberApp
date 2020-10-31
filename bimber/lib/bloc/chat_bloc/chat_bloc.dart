import 'dart:async';

import 'package:bimber/models/chat_message.dart';
import 'package:bimber/resources/repositories/chat_repositry.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String groupId;
  final ChatRepository repository;
  Stream<QueryResult> newMessages;

  ChatBloc({@required this.groupId, @required this.repository})
      : super(ChatInitial()) {
    newMessages = repository.newChatMessageStream(groupId: groupId);

    newMessages.listen((result) {
      if (result.hasException) {
        print('Error while receiving chat message: ' +
            result.exception.toString());
        return;
      }

      if (result.isLoading) {
        print('Waiting for chat message...');
        return;
      }

      add(DeliverNewChatMessage(message: ChatMessage.fromJson(result.data)));
    });
  }

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is DeliverNewChatMessage) {
      yield NewChatMessage(message: event.message);
    }
    if (event is FetchChatMessages) {
      yield* _mapFetchChatMessagesEvent(event);
    }
    if (event is SendChatMessage) {
      yield* _mapSendChatMessageEvent(event);
    }
  }

  Stream<ChatState> _mapFetchChatMessagesEvent(FetchChatMessages event) async* {
    yield ChatFetchLoading();

    try {
      final messages = await repository.fetchChatMessages(
          groupId: groupId, limit: event.limit, lastDate: event.lastDate);
      yield ChatMessagesFetched(messages: messages);
    } catch (e) {
      print(e);
      yield ChatError(
          message: "Wystąpił błąd podaczas wczytywania wiadomości!");
    }
  }

  Stream<ChatState> _mapSendChatMessageEvent(SendChatMessage event) async* {
    try {
      await repository.sendChatMessage(
          message: event.message, groupId: groupId);

      yield ChatMessageSent();
    } catch (e) {
      print(e);
      yield ChatError(message: "Wystąpił błąd podczas wysyłania wiadomości!");
    }
  }
}
