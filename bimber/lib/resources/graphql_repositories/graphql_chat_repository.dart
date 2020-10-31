import 'package:bimber/models/message.dart';
import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/chat_message.dart';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/chat_repositry.dart';
import 'package:bimber/graphql/queries.dart' as query;
import 'package:bimber/graphql/mutations.dart' as mutation;
import 'package:bimber/graphql/subscriptions.dart' as subscription;
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class GraphlqlChatRepository extends ChatRepository {
  final ValueNotifier<GraphQLClient> client;

  GraphlqlChatRepository({@required this.client});

  @override
  Future<List<ChatMessage>> fetchChatMessages(
      {String groupId, int limit = 100, DateTime lastDate}) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.loadChatMessages,
        fetchResults: true,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "gropuId": groupId,
          "limit": limit,
          "lastDate": lastDate?.toIso8601String(),
        });
    final queryResult = await client.value.query(options);
    checkQueryResultForErrors(queryResult);

    return List<ChatMessage>.from(queryResult.data["loadChatMessages"])
        .map((msg) => ChatMessage.fromJson(msg));
  }

  @override
  Future<List<ChatThumbnail>> fetchChatThumbnails() async {
    return [];
  }

  @override
  Future<Message> sendChatMessage({ChatMessage message}) async {
    final MutationOptions options = MutationOptions(
        document: mutation.sendChatMessage,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: message.toJson());

    final queryResult = await client.value.mutate(options);
    checkQueryResultForErrors(queryResult);

    return Message.fromJson(queryResult.data["sendChatMessage"]);
  }

  Stream<QueryResult> newChatMessageStream({@required String groupId}) {
    final SubscriptionOptions options = SubscriptionOptions(
        document: subscription.newChatMessage,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {"groupId": groupId});

    return client.value.subscribe(options);
  }
}
