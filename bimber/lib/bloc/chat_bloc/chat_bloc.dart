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
    // TODO: implement mapEventToState
  }
}
