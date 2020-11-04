import 'package:bimber/models/message.dart';
import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/chat_message.dart';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/graphql/queries.dart' as query;
import 'package:bimber/graphql/mutations.dart' as mutation;
import 'package:bimber/graphql/subscriptions.dart' as subscription;
import 'package:bimber/resources/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

class GraphqlChatRepository extends ChatRepository {
  final ValueNotifier<GraphQLClient> client;

  GraphqlChatRepository({@required this.client});

  @override
  Future<List<ChatMessage>> fetchChatMessages(
      {String groupId, int limit = 100, DateTime lastDate}) async {
    final WatchQueryOptions options = WatchQueryOptions(
        document: query.loadChatMessages,
        fetchResults: true,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "groupId": groupId,
          "limit": limit,
          "lastDate": lastDate?.toIso8601String(),
        });
    final queryResult = await client.value.query(options);

    return (queryResult.data["loadChatMessages"] as List)
        .map((msg) => ChatMessage.fromJson(msg))
        .toList();
  }

  @override
  Future<List<ChatThumbnail>> fetchChatThumbnails({bool fetchCache}) async {
    final WatchQueryOptions options = WatchQueryOptions(
      document: query.chatThumbnails,
      fetchResults: true,
      // network only as chat thumnnails does not have typename and id
      fetchPolicy: FetchPolicy.networkOnly,
    );
    final queryResult = await client.value.query(options);

    return (queryResult.data["chatThumbnails"] as List)
        .map((msg) => ChatThumbnail.fromJson(msg))
        .toList();
  }

  @override
  Future<Message> sendChatMessage({String groupId, String message}) async {
    final MutationOptions options = MutationOptions(
        document: mutation.sendChatMessage,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: {
          "groupId": groupId,
          "message": message,
        });

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
